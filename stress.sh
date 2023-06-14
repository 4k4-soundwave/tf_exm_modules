    amazon-linux-extras install -y nginx1
    systemctl enable nginx --now
    sudo amazon-linux-extras install epel -y
    sudo yum install stress -y
    stress --cpu 80