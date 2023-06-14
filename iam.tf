##########################################
# Roles 
##########################################

resource "aws_iam_role" "ssm_mgmt" {
  name               = var.iam_role_ssm_mgmt.name
  assume_role_policy = var.iam_role_ssm_mgmt.assume_role_policy
  tags               = var.iam_role_ssm_mgmt.tags
}

##########################################
# Policy Attachments 
##########################################
resource "aws_iam_role_policy_attachment" "ssm_mgmt_attachment" {
  role       = aws_iam_role.ssm_mgmt.id
  policy_arn = var.policy_arn
}

resource "aws_iam_role_policy_attachment" "CloudWatchFullAccess_attachment" {
  role       = aws_iam_role.ssm_mgmt.id
  policy_arn = var.CloudWatchFullAccess_policy
}

##########################################
# Instance Profile 
##########################################

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = var.my_instance_profile
  role = aws_iam_role.ssm_mgmt.name

  tags = {
    name = "instance-profile"
  }
}

