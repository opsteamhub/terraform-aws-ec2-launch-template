terraform {
  required_version = ">= 1.3.1"
  backend "s3" {
    bucket = "opsteam-terraform-modules-tfstate-dev"
    key    = "terraform/OpsTeamModules/lt.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.38.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      "opsteam:id"        = "0001"
      "opsteam:client_id" = "CL003"
      environment         = "Dev"
      owner               = "TFProviders"
      project             = "ASG"
    }
  }
}