# Aws Eks Cluster Security Group 
resource "aws_security_group" "eks_cluster_sg" {
  name        = "backend-${var.environment}-EKSCluster-SG"
  description = "Default security group to allow inbound/outbound from the Eks Cluster"
  vpc_id      = "${aws_vpc.AwsVPC.id}"
  depends_on  = [aws_vpc.AwsVPC]
  tags = {
    Name        = "backend-${var.environment}-EKSCluster-SG"
    Environment = "${var.environment}"
  }
}
  
resource "aws_security_group_rule" "eks_control_plane_to_worker" {
  type        = "ingress"
  from_port   = 10250
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [aws_vpc.AwsVPC.cidr_block]
  security_group_id = aws_security_group.eks_cluster_sg.id
}

resource "aws_security_group_rule" "eks_worker_to_control_plane" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = [aws_vpc.AwsVPC.cidr_block]
  security_group_id = aws_security_group.eks_cluster_sg.id
}

resource "aws_security_group_rule" "eks_worker_internal" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  source_security_group_id = aws_security_group.eks_cluster_sg.id
  security_group_id = aws_security_group.eks_cluster_sg.id
}

resource "aws_security_group_rule" "eks_worker_to_internet" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_cluster_sg.id
}

