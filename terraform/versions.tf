terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket  = "amazing-heights-terraform-state"
    key     = "k3s/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"
    }
  }
}

