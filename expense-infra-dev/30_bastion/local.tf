locals {
  bastion_sg = data.aws_ssm_parameter.bastion_sg.value
  public_subnet = split(",",data.aws_ssm_parameter.public_subnet.value)[0]
  ami_id           = data.aws_ami.joindevops.id
}
