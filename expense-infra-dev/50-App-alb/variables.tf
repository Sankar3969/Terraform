# mysql security group creation varibles
variable App_alb {
  default     = "App-alb"
}
variable App_alb_desc {
  type        = string
  default     = "This security group for App_alb"
}

variable App_alb_tags {
  default     = {
    Environment = "dev-App_alb"
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

