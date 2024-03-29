terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.57.0"
    }
  }
  cloud {
    hostname = "acm.mzc-dpt.com"
    organization = "ACM"

    workspaces {
      name = "acm"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
    Env  = "Stage"
    Test = "22"
  }
}

#AWS_ACCESS_KEY_ID
#AWS_SECRET_ACCESS_KEY