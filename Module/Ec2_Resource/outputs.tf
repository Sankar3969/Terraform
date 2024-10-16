# output "privateIp" {
#   value = aws_instance.Ec2_instance["backend"]
# }
# output "publicIp" {
#   value = aws_instance.Ec2_instance["frontend"]
# }
output "instance_Id" {
  value = aws_instance.Ec2_instance["mysql"].public_ip
}

