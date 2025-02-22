provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_java" {
  ami           = "ami-05b10e08d247fb927"  # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "cartaxopair"  # Use uma chave SSH válida

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
    Name = "Servidor-Java"
  }
}

output "public_ip" {
  description = "IP público da EC2"
  value       = aws_instance.app_java.public_ip
}
