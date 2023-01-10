# Main terraform file for ALL the environments!!!
terraform {
  required_version = "1.2.4"  
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "onebeyond-paula"

    workspaces {
      name = "test"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20.0"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id = "vpc-0ce75aaa035e86fae"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "app_server" {
  ami = "ami-830c94e3"
  instance_type = "t2.micro"
  key_name = "AWS"

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

  tags = {
    Name = "AppServerInstance"
  }

  depends_on = [ aws_security_group.allow_ssh ]
  
}

# resource "aws_instance" "app_server2" {
#     # ami                                  = "ami-03f8756d29f0b5f21"
#     # availability_zone                    = "us-west-2a"
#     # instance_type                        = "t2.micro"
#     # key_name                             = "AWS"
#     # security_groups                      = [
#     #     "test-sg",
#     # ]
#     # subnet_id                            = "subnet-08846cac2c6aaf9ac"
#     # tags                                 = {
#     #     "Name" = "appconsole"
#     # }
#     # tags_all                             = {
#     #     "Name" = "appconsole"
#     # }
#     # # vpc_security_group_ids               = [
#     # #     "sg-098d446bdba18db8a",
#     # # ]

# }