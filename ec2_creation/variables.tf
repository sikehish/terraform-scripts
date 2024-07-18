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

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type = string
}