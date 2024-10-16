variable "ami_id" {
    type =string
}

variable "instance_type" {
    type = map(string)

    validation {
      condition = alltrue([ for value in values(var.instance_type) : contains(["t3.micro", "t3.small"],value) ])
      error_message = "You should give the values t3.micro or t3.small"
    }
} 

variable "sg_id" {
    type = list(string)
}

variable "common_tags"{
    type = map(string)
}

variable "tags"{
    type = map(string)
}