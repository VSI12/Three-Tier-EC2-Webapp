terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "4.50.0"
        }
    }
    required_version = ">= 1.0.0"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "jenkins" {
  ami = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  user_data = templatefile("jenkins.sh", {})

  root_block_device {
    volume_type = "gp2"
    volume_size = 40
  }

  tags = {  
    Name = "Jenkins-SonarQube"
  }
}

resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Allow Jenkins inbound traffic"

  ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000]:
    {
      from_port   = port
      to_port     = port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}