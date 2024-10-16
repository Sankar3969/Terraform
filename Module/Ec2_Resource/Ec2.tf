resource "aws_instance" "Ec2_instance" {
  ami = var.ami_id
  for_each = var.instance_type
  instance_type = each.value
  vpc_security_group_ids =var.sg_id
  tags = merge(
    var.common_tags,
    var.tags,
    {
        Name =each.key
    }
  )
}