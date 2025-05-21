data "aws_ssm_parameter" "frontend_sg" {
  name = "/Expense/dev/frontend-sg"
}
data "aws_ssm_parameter" "vpc_id" {
  name = "/expense/dev/vpc_id"
}
data "aws_ssm_parameter" "public_subnet" {
  name = "/expense/dev/public_sub"
}
data "aws_ssm_parameter" "web_lb_listener_http" {
  name = "/expense/dev/web_lb_listener_http"
}
data "aws_ssm_parameter" "web_lb_listener_https" {
  name = "/expense/dev/web_lb_listener_https"
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