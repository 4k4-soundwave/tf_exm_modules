variable "aws_region" {
  description = "AWS region where the resources will be created."
  type        = string
  default     = "eu-west-1"
}

variable "image_name" {
  default     = "amzn2-ami-kernel-*-x86_64-gp2"
  type        = string
  description = "Amazon linux image name"
}

variable "policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

variable "CloudWatchFullAccess_policy" {
  type    = string
  default = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "cidr_ranges" {
  type = map(string)
  default = {
    //"full_network" = "172.16.0.0/16"
    "pub_sub1"  = "172.16.1.0/24"
    "pub_sub2"  = "172.16.3.0/24"
    "prvt_sub1" = "172.16.4.0/24"
    "prvt_sub2" = "172.16.5.0/24"
  }
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}

variable "iam_role_ssm_mgmt" {
  description = "IAM role configuration."
  type = object({
    name               = string
    assume_role_policy = string
    tags               = map(string)
  })
  default = {
    name               = "ssm-mgmt"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
    tags = {
      name = "role"
    }
  }
}

variable "iam_role_name" {
  description = "Name of the IAM role."
  type        = string
  default     = "ssm_selfmade"
}

variable "my_instance_profile" {
  description = "Instance profile"
  type        = string
  default     = "instance-profile"
}
