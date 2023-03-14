// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template?ref=dept-r-engineering-blog

resource "aws_launch_template" "ec2_lt" {
  name = "phonebook-app_ec2_lt"
  image_id = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  key_name = "arrow"
  security_groups = ["phonebook_ec2_sec-grp"]
  network_interfaces {
  associate_public_ip_address = true
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Web Server of phonebook application"
    }
  }
  user_data = file("${path.module}/phonebook-userdata.sh")
}












resource "aws_instance" "arrow_roman-numerals_ec2" {
  ami           = "ami-006dcf34c09e50022"   # linux
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.arrow.id ]
  associate_public_ip_address = var.enable_public_ip
  subnet_id = "subnet-069d7f45d2659c70c" ## us-east-1a
  user_data = file("${path.module}/arrow_userdata.sh") 
  tags = {
    Name = var.instance_name
  }
}



