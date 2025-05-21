module "App_alb" {
  source  = "terraform-aws-modules/alb/aws"
  internal =true
  name = "${var.Project}-${var.Environment}-${var.App_alb}"
  vpc_id             = local.vpc_id
  subnets            = local.private_subnet
  security_groups    = [local.App_alb_sg]
  create_security_group = false
  enable_deletion_protection = false
  tags = merge(
    var.common_tags,
    var.App_alb_tags,
  {
    Name = "${var.Project}-${var.Environment}-${var.App_alb}"
  })
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.App_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>I am from load balance listner</h1>"
      status_code  = "200"
    }
  }
  
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name

  records = [
    {
      name    = "*.app-${var.Environment}"
      type    = "A"
      alias   = {
        name    = module.App_alb.dns_name
        zone_id = module.App_alb.zone_id
      }
      
    }
  ]
  

}