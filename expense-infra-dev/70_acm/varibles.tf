# mysql security group creation varibles
variable aws_cert {
  default     = "certificate"
}
variable aws_cert_desc {
  type        = string
  default     = "This security group for aws_cert"
}

variable aws_cert_tags {
  default     = {
    Environment = "dev-aws_cert"
  }
}
variable common_tags {
  type        = map(string)
  default     = {
    project   = "expense"
    Terraform = true
  }
}

variable Environment {
  type        = string
  default     = "dev"
}


variable project {
  type        = string
  default     = "Expense"
}
variable "zone_name" {
  type        = string
  default     = "sankardevops.shop"
}



