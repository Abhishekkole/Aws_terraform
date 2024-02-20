/*==== The VPC ======*/
resource "aws_vpc" "AwsVPC" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "kubernetes.io/cluster/assignmnet-${var.environment}-EKSCluster" = "shared"	
    Name        = "assignment-${var.environment}-vpc"
    Environment = "${var.environment}"
    
  }
}