# Aws Eks Worker Node Group Security Group
resource "aws_security_group" "kubectl-server-sg" {
  name_prefix = "backend-${var.environment}-kubectl-server-sg"
  description = "security group to allow inbound/outbound from the Kubectl server"
  vpc_id      = "${aws_vpc.AwsVPC.id}"
  depends_on  = [aws_vpc.AwsVPC]
  tags = {
    Name        = "backend-${var.environment}-nodegroup-sg"
    Environment = "${var.environment}"
  }
}


# Inbound rule for Kubectl server Access
resource "aws_security_group_rule" "kubectl_server_ssh_access" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Allow access from all IP addresses
  security_group_id = aws_security_group.kubectl-server-sg.id
}

# Inbound rule for Node-to-Node Communication
resource "aws_security_group_rule" "eks_worker_internal_all_traffic_rule" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  source_security_group_id = aws_security_group.eks-nodegroup-sg.id
  security_group_id = aws_security_group.kubectl-server-sg.id
}

# Outbound rule for Internet Access
resource "aws_security_group_rule" "kubectl_all_internet_rule" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kubectl-server-sg.id
}

# Add more inbound and outbound rules as needed for specific services/resources.
