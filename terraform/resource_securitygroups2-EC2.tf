// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule#source_security_group_id
// https://stackoverflow.com/questions/71951434/terraform-ingress-with-source-security-group-id-vs-computed-ingress-with-sourc
// https://stackoverflow.com/questions/41825367/how-to-use-cidr-block-and-source-security-group-id-in-ingress-terraform-rule


resource "aws_security_group" "ec2_sec-grp" {
  name        = "phonebook_ec2_sec-grp"
  description = "phonebook_ec2_sec-grp enables HTTP for Flask Web Server and SSH for getting into EC2"
  ingress {
    description = "Allow Port 80 comes from application load balancer security group "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["phonebook_alb_sec-grp"]
    # security_groups = ["${aws_security_group.alb_sec-grp.id}"]
    # source_security_group_id = [aws_security_group.alb_sec-grp.id]
  }
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phonebook-application_ec2_secgrp"
  }
}