variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
}
variable instance_list {
    type = map(string)
   
}

variable tags {
  type        = map(string)
}

variable "common_tags" {
    default = {
        project = "expense"
        terraform = "true"
    }
}
variable zone_id {
    type = string
    default = "Z0370444A4TSW4G7B7G0"
}
variable dns_name {
    type = string
    default = "sankardevops.shop"
}

variable "env" {
  type        = string
}

