module "web_alb" {
  source  = "terraform-aws-modules/alb/aws"
  internal =false
  name = "${var.Project}-${var.Environment}-${var.web_alb}"
  vpc_id             = local.vpc_id
  subnets            = local.public_subnet
  security_groups    = [local.web_alb_sg]
  create_security_group = false
  enable_deletion_protection = false
  tags = merge(
    var.common_tags,
    var.web_alb_tags,
  {
    Name = "${var.Project}-${var.Environment}-${var.web_alb}"
  })
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>I am from load balance listner for http</h1>"
      status_code  = "200"
    }
  }
  
}


resource "aws_lb_listener" "https" {
  load_balancer_arn = module.web_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.aws_cert


  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>I am from web load balance listner for https</h1>"
      status_code  = "200"
    }
  }
  
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name

  records = [
    {
      name    = "expense-${var.Environment}"
      type    = "A"
      alias   = {
        name    = module.web_alb.dns_name
        zone_id = module.web_alb.zone_id
      }
      
    }
  ]
  

}