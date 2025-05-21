variable cidr_block {
    default = "10.0.0.0/16"
}
variable instance_tenancy {
  default     = "default"
}
variable int_gtw_tag {
    default = {
        Name = "Expense-int-gateway"
    }
}
variable avail_zone {
    default = "us-east-1a"
}
variable "public_ip" {
    default = true
}

variable "public_subnet" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
       
}
variable "private_subnet" {
    
    default = ["10.0.11.0/24", "10.0.12.0/24"]
       
}

variable "database_subnet" {
    default = ["10.0.21.0/24", "10.0.22.0/24"]
}
variable env {
  default   = {
  env = "dev"
}
}

variable Environment {
  default     = "dev"
}
variable is_peering_req {
    default = true
}

variable dest_cidr_block {
  default     = "0.0.0.0/0"
}

# security group creation varibles
variable mysql {
  default     = "mysql"
}
variable description {
  type        = string
  default     = "This security group for mysql"
}

output module_vpc {
  value       = module.vpc.vpc_id
}
