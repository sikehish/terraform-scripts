provider "aws" {
    region="us-east-1"
}

resource "aws_key_pair" "rsa_key_pair"{
    key_name = "sikehish-terraform"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "hish_vpc" {
    cidr_block = var.vpc_cidr
}

resource "aws_subnet" "hish_subnet_1"{
    vpc_id=aws_vpc.hish_vpc.id
    cidr_block = var.subnet_cidr
    availability_zone = var.subnet_az
    map_public_ip_on_launch= true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.hish_vpc.id
}

resource "aws_route_table" "route_1"{
    vpc_id = aws_vpc.hish_vpc.id
    route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta_1" {
    subnet_id = aws_subnet.hish_subnet_1.id
    route_table_id=aws_route_table.route_1.id
}

resource "aws_security_group" "hish_web_sg" {
  name="hish_web"
  vpc_id = aws_vpc.hish_vpc.id
  ingress {
    description = "HTTP from VPC"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags={
    Name="hish-web-sg"
  }
}

resource "aws_instance" "server" {
  ami = var.ami_id
  instance_type = "t2.micro"
  key_name = aws_key_pair.rsa_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.hish_web_sg.id]
  subnet_id = aws_subnet.hish_subnet_1.id

    connection {
      type="ssh"
      user="ubuntu"
      host=self.public_ip
      private_key = file("~/.ssh/id_rsa")
    }

    provisioner "file" {
        source = "app.py" #path of the local file
        destination = "/home/ubuntu/app.py" #destination path on remote instance
    }

    provisioner "remote-exec" {
        inline = [
            "echo 'Hello from server!'",
            "sudo apt update -y",
            "sudo apt install -y python3-pip",
            "cd /home/ubuntu",
            "sudo pip3 install flask",
            "sudo nohup python3 app.py &"
            # nohup ensures that the process is not terminated when the session is closed. The & at the end of the command places the process in the background, allowing the terminal to be used for other commands.
        ]
    }
}




