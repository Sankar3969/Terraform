resource "aws_ssm_parameter" "vpc_id" {
  name        = "/expense/dev/vpc_id"
  type        = "String"
  value       = module.vpc.vpc_id
  tags = {
    environment = "Expense-dev"
  }
}

resource "aws_ssm_parameter" "subnet_ids" {
  name        = "/expense/dev/public_sub"
  type        = "String"
  value       = join (",",module.vpc.public_subnets)
  tags = {
    environment = "Expense-dev"
  }
  overwrite = true
}
resource "aws_ssm_parameter" "private_subnet_ids" {
  name        = "/expense/dev/private_sub"
  type        = "String"
  value       = join (",",module.vpc.private_subnets)
  tags = {
    environment = "Expense-dev"
  }
  overwrite = true
}
resource "aws_ssm_parameter" "database_subnet_ids" {
  name        = "/expense/dev/database_sub"
  type        = "String"
  value       = join (",",module.vpc.database_subnets)
  tags = {
    environment = "Expense-dev"
  }
  overwrite = true
}
resource "aws_ssm_parameter" "aws_db_subnet_group" {
  name        = "/expense/dev/aws_db_subnet_group"
  type        = "String"
  value       = module.vpc.aws_db_subnet_group
  tags = {
    environment = "Expense-dev"
  }
  overwrite = true
}