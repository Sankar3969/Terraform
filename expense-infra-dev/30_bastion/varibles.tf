# mysql security group creation varibles
variable bastion {
  default     = "bastion"
}
variable mysql_desc {
  type        = string
  default     = "This security group for mysql"
}

variable bastion_tags {
  default     = {
    Environment = "dev-bashion"
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


