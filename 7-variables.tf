# Define a variable for the AWS region
variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "ap-south-1" # You can change the default value to your preferred region
}

# This variable is a placeholder for the AWS Access Key ID.
# DO NOT store actual access keys here for security reasons.
variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  default     = ""
}

# This variable is a placeholder for the AWS Secret Access Key.
# DO NOT store actual secret keys here for security reasons.
variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  default     = ""
}

# Define a variable for the Environment
variable "environment" {
  description = "The environment for your infrastructure"
  type        = string
  default     = "dev"
}

# Define a variable for the availability zones
variable "availability_zones" {
  description = "List of availability zones in us-east-1"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}


# Define a variable for the VPC CIDR block
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.18.0.0/16"
}

variable "public_subnets_cidr" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.18.0.0/24", "10.18.1.0/24", "10.18.2.0/24"]
}

variable "private_subnets_cidr" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.18.3.0/24", "10.18.4.0/24", "10.18.5.0/24"]
}

# Define a variable for the instance type
variable "instance_type" {
  description = "The EC2 instance type for your instances."
  type        = string
  default     = "t2.micro"
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

  default = [
    {
      name    = "kube-proxy"
      version = "v1.27.1-eksbuild.1"
    },
    {
      name    = "vpc-cni"
      version = "v1.12.6-eksbuild.2"
    },
    {
      name    = "coredns"
      version = "v1.10.1-eksbuild.1"
    }
  ]
}

# Define a list of port numbers
variable "nodegroup_ports" {
  description = "List of ports to allow"
  type        = list(number)
  default     = [22, 80, 443, 8080] # Default ports to allow
}

# Define the allowed IP ranges
variable "nodegroup_cidr_blocks" {
  description = "Allowed IP ranges"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Default to allowing from anywhere
}

# Define the Instance Type
variable "kubectl_instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
  default     = "t2.micro"  # Change to your desired instance type
}

# Define the key name for kubectl server
variable "key_name" {
  description = "The name of the SSH key pair for EC2 instance access."
  type        = string
  default     = "backend-cluster-keypair"  # Change to your SSH key pair name
}


# Define a variable for repository names
variable "repository_names" {
  description = "List of ECR repository names"
  type        = list(string)
  default     = ["hodr", "bran"]
}
