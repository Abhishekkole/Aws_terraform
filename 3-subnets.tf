/* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.AwsVPC.id}"
  count                   = "${length(var.public_subnets_cidr)}"
  cidr_block              = "${element(var.public_subnets_cidr,   count.index)}"
  availability_zone       = "${element(var.availability_zones,   count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name        = "backend-${var.environment}-aws-${element(var.availability_zones, count.index)}-public-subnet"
    "kubernetes.io/cluster/backend-${var.environment}-EKSCluster"      = "shared"
    "kubernetes.io/role/elb" = "1"
    Environment = "${var.environment}"
  }
}
/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.AwsVPC.id}"
  count                   = "${length(var.private_subnets_cidr)}"
  cidr_block              = "${element(var.private_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones,   count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name        = "backend-${var.environment}-aws-${element(var.availability_zones, count.index)}-private-subnet"
    "kubernetes.io/cluster/backend-${var.environment}-EKSCluster"      = "shared"	
    "kubernetes.io/role/internal-elb" = "1"
    Environment = "${var.environment}"
  }
}