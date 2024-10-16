module "Ec2" {
   source = "../Ec2_resource"
   ami_id = var.ami_id
   instance_type = var.instance_type
   sg_id = var.sg_id
   common_tags = var.common_tags
   tags = var.tags
}

