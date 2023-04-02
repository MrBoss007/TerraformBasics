terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "terraformstate007"
    key    = "prj1"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "creds.txt"
  profile = "TerraformPipeline"
  # If Hardcorded in Provider File
  # access_key = "AKIAZI7FZ7VZILDPPUFH"
  # secret_key = "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"
}