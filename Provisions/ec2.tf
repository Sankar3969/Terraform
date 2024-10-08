resource "aws_instance" "Ec2_instance_creation" {
  for_each = var.Instance_list
  ami = var.ami_id
  instance_type = each.value
  vpc_security_group_ids = [local.aws_sg_id]
  tags = {
    Name = each.key
  }

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip} > private.txt"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }
   provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl restart nginx",
      "sudo systemctl enable nginx"
    ]
  }
  provisioner "local-exec" {
    when    = destroy
    command = "sudo systemctl stop nginx"
  }
}

resource "aws_route53_record" "Aws_zone" {
  for_each   = local.aws_inst
  zone_id = "Z0370444A4TSW4G7B7G0"
  name    = each.key == "frontend" ? "${var.dns_name}" : "${each.key}.${var.dns_name}"
  type    = "A"
  ttl     = 1
  records = each.key == "frontend" ? [each.value.public_ip] : [each.value.private_ip]
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
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port        = ingress.value.from_port # each.value["rom_port"]
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
    }
    
  }

  
  tags =  {
        Name = "Allow-Pro-Sh"
    }
}





