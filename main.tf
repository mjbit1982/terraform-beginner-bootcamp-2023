terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    } 
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "random" {
  # Configuration options
}
#Random String Resource Document
#https://registry.terraform.io/providers/hashicorp/random/latest/docs
resource "random_string" "bucket_name" {
  lower            = true
  length           = 32
  special          = false
  upper            = false 
}
#S3 Bucket Resource Document 
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  #Bucket Naming Rules 
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = random_string.bucket_name.result
}
output "random_bucket_name" {
    value = random_string.bucket_name.result
  }
