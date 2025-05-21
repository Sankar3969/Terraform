# mysql security group creation varibles
variable web_alb {
  default     = "web-alb"
}
variable web_alb_desc {
  type        = string
  default     = "This security group for web_alb"
}

variable web_alb_tags {
  default     = {
    Environment = "dev-web_alb"
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

