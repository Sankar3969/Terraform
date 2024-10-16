# output "privateIp" {
#   value = module.Ec2["private_ip"]
# }
# output "publicIp" {
#   value = module.Ec2["public_ip"]
# }
output "instance_Id" {
  value = module.Ec2.instance_Id
}


