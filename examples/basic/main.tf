terraform {
  required_version = ">= 1.7.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0, < 7.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "launch_template" {
  source = "../.."

  default_tags = {
    Environment = "example"
    Project     = "terraform-modules"
    Owner       = "platform"
  }

  launch_template_config = {
    example = {
      name_prefix   = "example-"
      instance_type = "t3.micro"
    }
  }
}
