variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
}
variable instance_list {
    type = map(string)
    default ={
      mysql = "t3.small"
      backend ="t3.micro"
      frontend ="t3.micro"
    }
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


