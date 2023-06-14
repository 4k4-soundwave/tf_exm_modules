##########################################
# Autoscaling Group
##########################################

resource "aws_autoscaling_group" "my_asg" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.private_sub1.id, aws_subnet.private_sub2.id]
  target_group_arns   = [aws_lb_target_group.nginx.arn]

  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }
}

##########################################
# ASG Policy
##########################################

resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "the-auto-policy"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 4
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}

##########################################
# Attach Policy
##########################################

resource "aws_autoscaling_attachment" "asg_attachment_lb" {
  autoscaling_group_name = aws_autoscaling_group.my_asg.id
  lb_target_group_arn    = aws_lb_target_group.nginx.arn
}
