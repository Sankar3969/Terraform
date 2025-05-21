locals {
  frontend_sg = data.aws_ssm_parameter.frontend_sg.value
  public_subnet = split(",",data.aws_ssm_parameter.public_subnet.value)[0]
  ami_id           = data.aws_ami.joindevops.id
  vpc_id           = data.aws_ssm_parameter.vpc_id.value
  web_alb_listner_http  = data.aws_ssm_parameter.web_lb_listener_http.value
  web_alb_listner_https  = data.aws_ssm_parameter.web_lb_listener_https.value
}
