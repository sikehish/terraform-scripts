provider "aws" {
  region = var.bucket_region
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
}
