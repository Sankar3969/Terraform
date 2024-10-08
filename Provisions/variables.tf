variable res_name {
  type        = string
  default     = "Allow-Shh-Tf"
  description = "description"
}

variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
  description = "ami id creation"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "instance_type"
}

variable rs_tags {
    type = map(string)
    default = {
        Name = "terraform"
        }
}
variable sg_tags {
    type = map(string)
     default = {
        Name = "Allow-Shh-Tf"
        }
}
variable from_port {
  type        = number
  default     = 22
  description = "description"
}
variable to_port {
  type        = number
  default     = 22
  description = "description"
}
variable proto {
     type = string
     default = "tcp"
}

variable cidr_block {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "description"
}
variable "test" {
  type        = string
  default     = "test-var"
  description = "description"
}
variable Instance_list {
  type        = map(string)
  default     = {
    mysql     = "t2.small"
    frontend  = "t3.micro"
    backend   = "t3.micro"
  }
}
variable Env {
  type        = string
  default     = "Dev"
  description = "description"
}
variable dns_name {
  type        = string
  default     = "sankardevops.shop"
  description = "description"
}

#complext Object Variable
variable complex_Object {
  type   = object({
      Name = string
      id   = number
      Address = object({
        Hno = number
        Phno = number
        Street = string
        Other_details = object({
            Nationality = string
            religion = string
            
          })
      })
      Billing_Addr = list(string)
      })
      default = {
        Name= "Sankar"
        id = 123
        Address = {
          Hno = 456
          Phno = 87875484545
          Street = "friston path"
          Other_details = {
            Nationality = "Indian"
            religion = "Hindu"
          }
        }
        Billing_Addr = ["5-10","first line"]
      }
}

variable ingress_rules {
  default     =  [
                   
                    {
                    from_port        = 22
                    to_port          = 22
                    protocol         = "tcp"
                    cidr_blocks      = ["0.0.0.0/0"]
                    ipv6_cidr_blocks = ["::/0"]
                  },
                   {
                    from_port        = 80
                    to_port          = 80
                    protocol         = "tcp"
                    cidr_blocks      = ["0.0.0.0/0"]
                    ipv6_cidr_blocks = ["::/0"]
                  }
  ]
 
}




