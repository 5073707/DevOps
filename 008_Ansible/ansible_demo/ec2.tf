provider "aws" {
  region = "eu-north-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "jenkins_master" {
  ami                    = "ami-0fe8bec493a81c7da"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.jenkins_master.id]
  key_name               = "Admin57_2"

  tags = {
    Name  = "Jenkins"
    Owner = "MaxKhal"
  }
}

resource "aws_security_group" "jenkins_master" {
  name        = "Jenkins Security Group"
  description = "CI_CD SecurityGroup"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Jenkins"
    Owner = "MaxKhal"
  }

}

output "jenkins_host" {
  value = aws_instance.jenkins_master.public_ip
}