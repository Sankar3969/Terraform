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
variable "test" {
  type        = string
  default     = "test-var"
  description = "description"
}

