data "aws_ssm_parameter" "bastion_sg" {
  name = "/Expense/dev/bastion-sg"
}

data "aws_ssm_parameter" "public_subnet" {
  name = "/expense/dev/public_sub"
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