module "vpc" {
  source = "git::https://github.com/Sankar3969/Terraform.git?ref=main"
  cidr_block  = var.cidr_block
  instance_tenancy = var.instance_tenancy
  int_gtw_tag      = var.int_gtw_tag
  avail_zone       = var.avail_zone
  public_ip        = var.public_ip
  public_subnet    = var.public_subnet
  private_subnet   = var.private_subnet
  database_subnet  = var.database_subnet
  env              = var.env
  Environment      = var.Environment
  is_peering_req   = var.is_peering_req
  dest_cidr_block  = var.dest_cidr_block
}
