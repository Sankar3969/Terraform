locals {
  subnet_group_name = data.aws_ssm_parameter.aws_db_subnet_group.value
  db_security_grp   = data.aws_ssm_parameter.mysql_sg.value
}
