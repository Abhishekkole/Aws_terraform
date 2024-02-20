resource "aws_iam_role" "eks_cluster_role" {
  name = "backend-${var.environment}-EKSClusterRole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "eks_cluster_attachment" {
  name       = "eks-cluster-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles      = [aws_iam_role.eks_cluster_role.name]
}

resource "aws_iam_policy_attachment" "eks_service_attachment" {
  name       = "eks_service_attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  roles      = [aws_iam_role.eks_cluster_role.name]
}

resource "aws_eks_cluster" "EksCluster" {
  name     = "backend-${var.environment}-EKSCluster"
  version = "1.27"
  role_arn = aws_iam_role.eks_cluster_role.arn

  enabled_cluster_log_types = ["api", "audit", "authenticator", "scheduler", "controllerManager"]

  vpc_config {
    endpoint_public_access = true   # Enable public access
    endpoint_private_access = true  # Enable private access
    security_group_ids = [aws_security_group.eks_cluster_sg.id] # Attach the security group here
    subnet_ids = aws_subnet.private_subnet[*].id
  }

  depends_on = [
    aws_iam_policy_attachment.eks_cluster_attachment,
    aws_iam_policy_attachment.eks_service_attachment,
  ]
}
