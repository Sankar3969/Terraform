resource "aws_ssm_parameter" "App_alb_listner" {
  name        = "/expense/dev/aws_lb_listener"
  type        = "String"
  value       = aws_lb_listener.http.arn
  tags = {
    environment = "Expense-dev"
  }
}

