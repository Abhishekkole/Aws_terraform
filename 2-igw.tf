/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "IGW" {
  vpc_id = "${aws_vpc.AwsVPC.id}"
  tags = {
    Name        = "backend-${var.environment}-IGW"
    Environment = "${var.environment}"
  }
}