# mysql security group creation varibles
variable vpn {
  default     = "vpn"
}
variable vpn_desc {
  type        = string
  default     = "This security group for vpn"
}

variable vpn_tags {
  default     = {
    Environment = "dev-vpn"
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


