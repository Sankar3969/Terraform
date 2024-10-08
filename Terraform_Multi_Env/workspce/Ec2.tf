resource "aws_instance" "Ec2_instance_creation" {
  ami = var.ami_id
  for_each = var.instance_list
  instance_type = each.value 
  vpc_security_group_ids =[aws_security_group.security_group.id]
  tags = merge (
    var.common_tags,
    {
      Name = "${each.key}-${terraform.workspace}"
    })

}

resource "aws_route53_record" "Aws_zone" {
    zone_id = var.zone_id
    for_each = local.aws_inst
    name = each.key == "frontend" ? "${var.dns_name}" : "${each.key}-${terraform.workspace}.${var.dns_name}"
    type = "A"
    ttl  = 1
    records= startswith(each.key, "frontend") ? [each.value.public_ip] : [each.value.private_ip]
}

locals {
  aws_inst = aws_instance.Ec2_instance_creation
}


resource "aws_security_group" "security_group" {
  # ... other configuration ...

  name = "Allow-Shh-${terraform.workspace}"
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
    Name = "Allow-Shh-${terraform.workspace}"
  }
}
