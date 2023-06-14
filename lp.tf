##########################################
# Launch Template 
##########################################

resource "aws_launch_template" "my_launch_template" {
  name_prefix            = "terraform"
  image_id               = data.aws_ami.latest_amazon_linux.image_id
  instance_type          = "t2.micro"
  update_default_version = true
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.iam_instance_profile.name
  }
  user_data = base64encode(
    <<-EOF
    #!/bin/bash
    amazon-linux-extras install -y nginx1
    systemctl enable nginx --now
    sudo amazon-linux-extras install epel -y
    sudo yum install stress -y
    stress --cpu 80 
    EOF
  )
  // base64encode(file("~/Downloads/AWS/aws_exam/stress.sh"))

  tags = {
    Name = "my-launch-template"
  }
}