# Create an Elastic IP resource
resource "aws_eip" "ec2_eip" {
  instance = aws_instance.ec2_instance.id
}

# Create an EC2 instance with dynamic AMI
resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.latest.id
  instance_type = var.kubectl_instance_type

  # Specify the security group as a dependency
  depends_on = [
    aws_security_group.kubectl-server-sg,
    aws_vpc.AwsVPC,  # Include any other dependencies if needed
  ]
  vpc_security_group_ids = [aws_security_group.kubectl-server-sg.id]  # Use vpc_security_group_ids

  # Configure the EC2 instance networking
  subnet_id     = aws_subnet.public_subnet[0].id  # Specify the subnet ID

  key_name      = var.key_name  # Specify the name of your existing key pair

  # Define the root block device with a 20GB EBS volume
  root_block_device {
    volume_size = 30
    volume_type = "gp2"  # You can specify a different volume type if needed
  }

  tags = {
    Name        = "backend-${var.environment}-Bastion-Server"
    Environment = "${var.environment}"
  }
}

# Query the latest Amazon Linux 2 AMI ID
data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}




