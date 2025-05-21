locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  private_subnet = split(",",data.aws_ssm_parameter.private_subnet.value)
  App_alb_sg     = data.aws_ssm_parameter.App_alb_sg.value
}
