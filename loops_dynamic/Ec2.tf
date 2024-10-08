resource "aws_instance" "Ec2_instance_creation" {
  ami = var.ami_id
  for_each = var.instance_list
  instance_type = each.value
  vpc_security_group_ids =[aws_security_group.security_group.id]
  tags = {
    Name = each.key
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ip.txt"
  }
  connection{
    type = "ssh"
    user = "ec2-user"
    password = " DevOps321"
    host = self.public_ip
    
  }
  provisioner "remote-exec" {
    inline = [
        "sudo dnf install nginx -y",
        "sudo systemctl start nginx",
        "sudo systemctl enable nginx"
    ]
  }
  provisioner "local-exec" {
    command = "sudo systemctl stop nginx"
  }
}

resource "aws_route53_record" "Aws_zone" {
    zone_id = "Z0370444A4TSW4G7B7G0"
    for_each = local.aws_res
    name = each.key == "frontend" ? "${var.dns_name}" : "${each.key}.${var.dns_name}"
    type = "A"
    ttl  = 1
    records= each.key == "frontend" ? [each.value.public_ip] : [each.value.private_ip]

}
locals {
  aws_res = aws_instance.Ec2_instance_creation
}

resource "aws_security_group"  "security_group" {
    name = "allow-ssh-pro"
    description = " security grp creation"

    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    dynamic "ingress" {
        
        for_each = var.ingress_list
        content  {
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            protocol = ingress.value.protocol
            cidr_blocks =ingress.value.cidr_blocks
        }
    }
    
    tags = {
       Name = "allow-ssh-lp"
    }
}