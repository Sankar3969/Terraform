resource "aws_instance" "Ec2_instance_creation" {
  
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]
  tags = var.rs_tags
}

resource "aws_security_group" "security_group" {
  # ... other configuration ...

  name = var.res_name
  description = "creating security grp throgh tf"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = var.proto
    cidr_blocks      = var.cidr_block
    ipv6_cidr_blocks = ["::/0"]
  }
  tags=var.sg_tags
}

