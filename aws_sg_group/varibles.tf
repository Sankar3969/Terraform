variable Environment {
  type        = string
}

variable project{
    type = string
    default = "Expense"
}

variable mysql {
  type        = string
  default     = "mysql"
  
}
variable description {
  type        = string
  default     = "This security group for mysql"
}

variable common_tags {
    type = map(string)
    default = {
     project = "Expense"
     Terraform = true
    }
}
variable mysql_tags {
  type        = string
  default     = {
    Environment = "expense-dev-mysql"
  }
}

