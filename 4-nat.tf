/* Elastic IP for NAT */
resource "aws_eip" "Nat_Eip" {
  domain   = "vpc"
  depends_on = [aws_internet_gateway.IGW]
}
/* NAT */
resource "aws_nat_gateway" "NAT" {
  allocation_id = "${aws_eip.Nat_Eip.id}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, 0)}"
  depends_on    = [aws_internet_gateway.IGW]
  tags = {
    Name        = "backend-${var.environment}-NAT"
    Environment = "${var.environment}"
  }
}