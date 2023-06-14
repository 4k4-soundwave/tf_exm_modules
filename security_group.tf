##########################################
# Security Group for VPC
##########################################
resource "aws_security_group" "allow_http" {
  name   = "for-asg"
  vpc_id = aws_vpc.flutt_vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.flutt_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_http"
  }
}

##########################################
# Security Group for LB
##########################################

resource "aws_security_group" "lb_sg" {
  name        = "nginx-lb"
  description = "Allow HTTP inbound traffic to load"
  vpc_id      = aws_vpc.flutt_vpc.id

  ingress {
    description = "Allow HTTP inbound traffic to load"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["91.211.97.132/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
