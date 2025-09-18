terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.0"
    }
  }
  backend "s3" {
    bucket               = "saif-devops-recipe-app-tf-state"
    key                  = "tf-state-deploy"
    region               = "ap-southeast-1"
    workspace_key_prefix = "tf-state-deploy-env"
    encrypt              = true
    dynamodb_table       = "saife-devops-recipe-app-tf-lock"
  }
}

provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      Contact     = var.contact
      ManageBy    = "Terraform/deploy"
    }
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}

data "aws_region" "current" {}