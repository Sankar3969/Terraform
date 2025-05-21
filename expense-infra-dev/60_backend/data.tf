data "aws_ssm_parameter" "backend_sg" {
  name = "/Expense/dev/backend-sg"
}
data "aws_ssm_parameter" "vpc_id" {
  name = "/expense/dev/vpc_id"
}
data "aws_ssm_parameter" "private_subnet" {
  name = "/expense/dev/private_sub"
}
data "aws_ssm_parameter" "aws_lb_listener" {
  name = "/expense/dev/aws_lb_listener"
}

data "aws_ami" "joindevops" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}