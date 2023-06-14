#########################################
# Cloudwatch config
#########################################
resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarm" {
  alarm_name          = "terraform-test-CMA"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "This metric monitors ec2 cpu utilization"
  treat_missing_data  = "breaching"
  alarm_actions       = [aws_autoscaling_policy.asg_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name
  }
}
