resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = var.tags
  security_groups = [aws_security_group.allow_ssh.name]
#   vpc_id   = var.vpc_id

    #  Terraform will create a new resource before destroying the old one during an update. This is particularly useful for resources where downtime or disruption must be minimized.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}