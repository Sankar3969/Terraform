# mysql security group creation varibles
variable database {
  default     = "database"
}
variable database_desc {
  type        = string
  default     = "This security group for database"
}

variable database_tags {
  default     = {
    Environment = "dev-database"
  }
}

variable Environment{
  default = "dev"
}

variable Project{
  default = "expense"
}

variable common_tags {
  type        = map(string)
  default     = {
    Project   = "Expense"
    Terraform = true
  }

}

variable zone_name {
  type        = string
  default     = "sankardevops.shop"
 
}

