variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  type        = string
  default="ami-04a81a99f5ec58529"
}

variable "key_name" {
  description = "The name of the SSH key pair to use"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  type = string
}

variable "bucket_name" {
  description = "S3 bucket name for remote backend to house the state file"
  type = string
}

variable "hash_key" {
  description = "DynamoDB hash key"
  type = string
}

variable "table_name" {
  description = "DynamoDB table name"
  type = string
}

variable "billing_mode" {
  description = "DynamoDB billing mode"
  type = string
}

variable "s3_backend_key" {
  description = "Key for S3 bucket serving as remote backend"
  type = string
}