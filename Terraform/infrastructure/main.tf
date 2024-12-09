terraform {

    backend "s3" {
      bucket         = "ids-project-terraform-state"
      key            = "tf-state/terraform.tfstate"
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

