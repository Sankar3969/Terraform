module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = local.ami_id
  name = "${var.project}-${var.Environment}-${var.bastion}"
  instance_type          = "t3.micro"

  vpc_security_group_ids = [local.bastion_sg]
  subnet_id              = local.public_subnet
  tags = merge(
    var.common_tags,
    var.bastion_tags,
    {
      Name = "${var.project}-${var.Environment}-${var.bastion}"
    }
  )
}