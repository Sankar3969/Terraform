resource "aws_ssm_parameter" "web_alb_listner_http" {
  name        = "/expense/dev/web_lb_listener_http"
  type        = "String"
  value       = aws_lb_listener.http.arn
  tags = {
    environment = "Expense-dev"
  }
}
resource "aws_ssm_parameter" "web_alb_listner_https" {
  name        = "/expense/dev/web_lb_listener_https"
  type        = "String"
  value       = aws_lb_listener.https.arn
  tags = {
    environment = "Expense-dev"
  }
}
