provider "aws" {
  region = var.aws_region
}

module "ec2_instance" {
  source       = "./modules/ec2_instance"
  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_name      = var.key_name
  tags          = var.tags
  vpc_id = var.vpc_id
}
