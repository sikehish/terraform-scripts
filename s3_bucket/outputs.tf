output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket.bucket
}

output "bucket_region" {
  description = "The AWS region of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket.region
}

output "bucket_domain_name" {
  description = "The bucket domain name (e.g., example-bucket.s3.amazonaws.com)"
  value       = aws_s3_bucket.s3_bucket.bucket_domain_name
}

output "bucket_arn" {
  description = "The ARN (Amazon Resource Name) of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}
