data "aws_ssm_parameter" "vpc_id" {
  name = "/expense/dev/vpc_id"
}
data "aws_ssm_parameter" "private_subnet" {
  name = "/expense/dev/private_sub"
}
data "aws_ssm_parameter" "App_alb_sg" {
  name = "/Expense/dev/app_alb-sg"
}