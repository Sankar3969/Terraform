resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn-key"
  public_key = file("~/.ssh/openvpn.pub")
}

module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.openvpn.key_name
  ami = local.ami_id
  name = "${var.project}-${var.Environment}-${var.vpn}"
  instance_type          = "t3.micro"

  vpc_security_group_ids = [local.vpn_sg]
  subnet_id              = local.public_subnet
  tags = merge(
    var.common_tags,
    var.vpn_tags,
    {
      Name = "${var.project}-${var.Environment}-${var.vpn}"
    }
  )
}