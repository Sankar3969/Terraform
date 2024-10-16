variable cidr_block {
    type = string
    default = "10.0.0.0/16"
}
variable instance_tenancy {
  type        = string
  default     = "default"
}
variable int_gtw_tag {
    type = map(string)
    default = {
        Name = "Expense-int-gateway"
    }
}
variable avail_zone {
    type = string
    default = "us-east-1a"
}
variable "public_ip" {
    type = bool
    default = true
}

variable "public_subnet" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
       
}
variable "private_subnet" {
    type = list(string)
    default = ["10.0.11.0/24", "10.0.12.0/24"]
       
}

variable "database_subnet" {
    type = list(string)
    default = ["10.0.21.0/24", "10.0.22.0/24"]
}
variable env {
  type        = map
  default     = {
          env = "dev"
}
}

variable Environment {
  type        = string
  default     = "dev"
}
variable is_peering_req {
    type = bool
    default = true
}

variable dest_cidr_block {
  type        = string
  default     = "0.0.0.0/0"
}
