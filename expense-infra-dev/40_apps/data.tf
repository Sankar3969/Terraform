data "aws_ssm_parameter" "aws_db_subnet_group" {
  name = "/expense/dev/aws_db_subnet_group"
}
data "aws_ssm_parameter" "mysql_sg" {
  name = "/Expense/dev/mysql-sg"
}