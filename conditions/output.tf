output sg_id {
  value       = aws_security_group.security_group.id
}

output "Ec2_Info" {
value = aws_instance.Ec2_instance_creation
}

output Ec2_Name {
value = aws_instance.Ec2_instance_creation[*].tags_all.Name
}

output Ec2_Length {
value = length(aws_instance.Ec2_instance_creation[*])
}

output complex_Object {
  value = var.complex_Object.Billing_Addr[*]
}
output Other_Det {
  value = var.complex_Object.Address.Other_details.religion
}
output "Sec_group_Id" {
  value = local.aws_sg_id
}
output "upper_vals" {
  value = local.upper_vals
}

output "cond_for" {
  value  = local.cond_for
  
}
output "Map_for" {
  value  = local.map_for["age"]
}
# output "Map_for1" {
#   value  = local.map_for1
  
# }
