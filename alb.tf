##########################################
# Application Load Balancer
##########################################

resource "aws_lb" "flutter_alb" {
  name               = "flutter-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_sub1.id, aws_subnet.public_sub2.id]

  enable_deletion_protection = false

}

##########################################
# AWS LB Target Group
##########################################

resource "aws_lb_target_group" "nginx" {
  name     = "nginx-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.flutt_vpc.id
}

##########################################
# AWS LB Listener
##########################################

resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.flutter_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
}
