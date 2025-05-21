# mysql security group creation varibles
variable backend {
  default     = "backend"
}
variable backend_desc {
  type        = string
  default     = "This security group for backend"
}

variable backend_tags {
  default     = {
    Environment = "dev-backend"
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



