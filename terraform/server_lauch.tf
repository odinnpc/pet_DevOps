resource "aws_instance" "web_server" {
  ami                    = "ami-0fa91bc90632c73c9"
  instance_type          = "t3.micro"
  key_name               = "super_duper"
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data              = templatefile("file_for_terraform.sh.tpl", {})

  tags = {
    Name    = "web_server_terraform"
    owner   = "anton_dev_ops"
    project = "terraform_lunch"
  }

  depends_on = [aws_instance.db_server]
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0fa91bc90632c73c9"
  instance_type          = "t3.micro"
  key_name               = "super_duper"
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data              = templatefile("file_for_terraform.sh.tpl", {})

  tags = {
    Name    = "app_server_terraform"
    owner   = "anton_dev_ops"
    project = "terraform_lunch"
  }

  depends_on = [aws_instance.db_server]
}

resource "aws_instance" "db_server" {
  ami                    = "ami-0fa91bc90632c73c9"
  instance_type          = "t3.micro"
  key_name               = "super_duper"
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data              = templatefile("file_for_terraform.sh.tpl", {})

  tags = {
    Name    = "db_server_terraform"
    owner   = "anton_dev_ops"
    project = "terraform_lunch"
  }
}
resource "aws_security_group" "nginx_sg" {
  name        = "web_app_db_security_group"
  description = "Allow HTTP/HTTPS/SSH"

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx_security_group"
  }
}
# EIP for web_server
resource "aws_eip" "web_server_eip" {
  instance = aws_instance.web_server.id
  domain   = "vpc"

  lifecycle {
    create_before_destroy = true
  }
}

# EIP for app_server
resource "aws_eip" "app_server_eip" {
  instance = aws_instance.app_server.id
  domain   = "vpc"

  lifecycle {
    create_before_destroy = true
  }
}

# EIP for db_server (usually DB doesn't need public EIP — remove if not required)
resource "aws_eip" "db_server_eip" {
  instance = aws_instance.db_server.id
  domain   = "vpc"

  lifecycle {
    create_before_destroy = true
  }
}