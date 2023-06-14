##########################################
# Lambda Role
##########################################
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({

    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "lambda.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })
}

##########################################
# Cloudwatch EC2 Policy
##########################################

resource "aws_iam_role_policy" "cloudwatch_ec2_policy" {
  name = "cloudwatch-ec2-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "forEC2",
        "Effect": "Allow",
        "Resource": "*", // "arn:aws:ec2:<region>:<account-id>:instance/<instance-id>"
        "Action": [
          "ec2:DescribeInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances"
        ]
      },
      {
        "Sid": "forASG",
        "Effect": "Allow",
        "Action": [
          "autoscaling:UpdateAutoScalingGroup",
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:SuspendProcesses"
        ],
        "Resource": "*" // "arn:aws:autoscaling:<region>:<account-id>:autoScalingGroup:<auto-scaling-group-id>""
      }
    ]
  })
}
