terraform {
  required_version = ">= 1.5.4"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      SemanticVersion = var.semantic_version
      Environment     = terraform.workspace
    }
  }
}