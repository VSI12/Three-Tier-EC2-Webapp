terraform {

    backend "s3" {
      bucket         = "three-tier-ec2-backend-tfstate"
      key            = "three-tier-ec2-backend-tflock"
      region         = "us-east-1"
      dynamodb_table = "ids-terraform-lock"
      encrypt        = true
    }
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

module "vpc" {
    source = "./modules/vpc"
}

module "s3" {
    source = "./modules/s3"
}