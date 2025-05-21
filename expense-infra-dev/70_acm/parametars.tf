resource "aws_ssm_parameter" "aws_cert" {
  name        = "/expense/dev/aws_cert"
  type        = "String"
  value       = aws_acm_certificate.expense.arn
  tags = {
    environment = "Expense-dev"
  }
}

