locals  {
  upper_vals = [for s in var.Instance_list : upper(s)]
}

locals {
  cond_for = [for s in var.Instance_list : upper(s) if s != "mysql"]
}

variable Per_info {
  type        = map(string)
  default     = {
     name = "Sankar"
     age  = "10"
     Job  = "DevOps"
  }
  
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "instance_types" {
  type    = list(string)
  default = ["t2.micro", "t2.medium"]
}
resource "aws_instance" "Exp" {
  for_each = [for instance_types in var.instance_types : "${instance_types}"]
  aws_inst = each.value
}

output aws_inst_val {
  value = aws_instance.Exp.aws_inst

}


locals {
 map_for = {for key, value in var.Per_info : key => value if key !="Job"}
 map_for1 = {for key, value in var.Per_info : upper(key) => value }
}