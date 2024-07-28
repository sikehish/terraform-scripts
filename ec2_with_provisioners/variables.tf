variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    default = "10.0.0.0/16"
}

variable "subnet_az" {
    default = "us-east-1a"
}

variable "ami_id" {
  type        = string
  default="ami-04a81a99f5ec58529"
}
