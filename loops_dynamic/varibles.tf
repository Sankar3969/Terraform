variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
}
variable instance_list {
    type = map(string)
    default ={
        mysql = "t2.small"
        backend = "t3.micro"
        frontend = "t3.micro"
    }
}

variable dns_name {
    type = string
    default = "sankardevops.shop"
}

variable ingress_list {
    default =[
        {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        },
        {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        }
       
    ]
}