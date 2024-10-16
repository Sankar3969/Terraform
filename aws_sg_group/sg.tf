resource "aws_security_group" "main" {
  name        = "${var.project}-${var.Environment}-${var.mysql}"
  description = var.description
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}