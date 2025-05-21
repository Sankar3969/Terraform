locals {
  backend_sg = data.aws_ssm_parameter.backend_sg.value
  private_subnet = split(",",data.aws_ssm_parameter.private_subnet.value)[0]
  ami_id           = data.aws_ami.joindevops.id
  vpc_id           = data.aws_ssm_parameter.vpc_id.value
  aws_lb_listener  = data.aws_ssm_parameter.aws_lb_listener.value
}
