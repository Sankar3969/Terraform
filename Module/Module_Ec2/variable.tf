variable "ami_id" {
    type =string 
    default = "ami-09c813fb71547fc4f"
}
variable "instance_type" {
    type = map(string)
    default ={
        mysql ="t3.small"
        backend = "t3.micro"
        frontend = "t3.micro"
    }
} 
variable "sg_id" {
    type = list(string)
    default = ["sg-0e7acc0270b66b95e"]
}

variable "common_tags"{
    type = map(string)
    default = {
        project = "Expense"
        Terraform = "true"
    }
}

variable "tags"{
    type = map(string)
    default ={
        Environment = "dev"
    }
}

