resource "aws_instance" "Ec2_instance_creation" {
  count = length(var.Instance_list)
  ami = data.aws_ami.joindevops.id
  instance_type = var.Env == "Prod" ? "t2.micro" : "t3.micro"
  vpc_security_group_ids = [local.aws_sg_id]
  tags = {
    Name = var.Instance_list[count.index]
  }
}

resource "aws_route53_record" "Aws_zone" {
  count   = length(var.Instance_list)
  zone_id = "Z0370444A4TSW4G7B7G0"
  name    = "${aws_instance.Ec2_instance_creation[count.index].tags_all.Name}.${var.dns_name}"
  type    = "A"
  ttl     = 1
  records = [local.aws_inst[count.index].private_ip]
}
locals {
  aws_sg_id = aws_security_group.security_group.id
}
locals {
  aws_inst = aws_instance.Ec2_instance_creation
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





