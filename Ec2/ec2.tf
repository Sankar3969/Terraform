resource "aws_security_group" "security_group" {
  # ... other configuration ...

  name = "Allow-Shh-Tf"
  description = "creating security grp throgh tf"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Allow-Shh-Tf"
  }
}

resource "aws_instance" "Ec2_instance_creation" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids =[aws_security_group.security_group.id]
  tags = {
    Name = "terraform"
  }
}