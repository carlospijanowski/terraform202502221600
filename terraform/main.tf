provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_java" {
  ami           = "ami-05b10e08d247fb927"  # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "cartaxopair"  # Use uma chave SSH válida

  # Adicione a VPC e a Subnet aqui
  subnet_id     = "subnet-019de342b52f0598a"  # Substitua pelo seu Subnet ID
  # vpc_security_group_ids = [aws_security_group.app_sg.id]
  vpc_security_group_ids = ["sg-098dd2785633ad011"]


  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras enable corretto8
              sudo yum install -y java-1.8.0-amazon-corretto
              cd /home/ec2-user
              wget https://meus-arquivos/meu-app.jar
              nohup java -jar meu-app.jar > output.log 2>&1 &
              EOF

  tags = {
    Name = "20250222 1600 - Java"
  }
}

output "public_ip" {
  description = "IP público da EC2"
  value       = aws_instance.app_java.public_ip
}

# resource "aws_security_group" "app_sg" {
#   name        = "allow-ssh-http"
#   description = "Habilita SSH e HTTP"
#   vpc_id      = "vpc-079bff02e3fe38790"  # Substitua pelo seu VPC ID
#
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
