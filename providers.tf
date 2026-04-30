terraform {
  # Remote backend configuration to store the state file in S3
  backend "s3" {
    bucket         = "fluxio-terraform-state-toure-2026"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-1"

    # State locking via DynamoDB to prevent concurrent modifications
    dynamodb_table = "fluxio-terraform-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
