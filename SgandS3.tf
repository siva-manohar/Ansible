provider "aws" {
  region = "us-east-2" # Specify your desired region
}

variable "vpc_id" {
    default= "vpc-046a49811d3690379"
}

# Create Security Group
resource "aws_security_group" "terraform_security" {
  vpc_id = var.vpc_id
  name   = "terraform_security"

  # Define your security group rules here
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform_securitygroup"
  }
}

# Create S3 Bucket
resource "aws_s3_bucket" "electionday-3011" {
  bucket = "electionday-3011"

  tags = {
    Name = "terraform_s3"
  }
}