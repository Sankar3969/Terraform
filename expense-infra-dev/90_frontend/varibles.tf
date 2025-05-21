variable frontend {
  default     = "frontend"
}
variable frontend_desc {
  type        = string
  default     = "This security group for frontend"
}

variable frontend_tags {
  default     = {
    Environment = "dev-frontend"
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



