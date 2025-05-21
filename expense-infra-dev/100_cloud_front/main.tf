resource "aws_cloudfront_distribution" "expense" {
  origin {
    domain_name              = "expense-dev.sankardevops.shop"
    origin_id                = "expense-dev.sankardevops.shop"
    custom_origin_config{
        origin_protocol_policy   = "https-only"
        https_port               = "443"
        http_port               = "80"
        origin_ssl_protocols     = ["TLSv1.2"]
    }
   
  }

  enabled             = true
 

  aliases = ["expense-cdn.sankardevops.shop"]

  default_cache_behavior {
    compress           = true
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD","OPTIONS"]
    target_origin_id = "expense-dev.sankardevops.shop"

    cache_policy_id  = local.cache_default_policy

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

ordered_cache_behavior {
    path_pattern     = "/image/*"
    compress         = true
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "expense-dev.sankardevops.shop"
    cache_policy_id  = local.cache_opti_policy
    
   

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    
  }
  
ordered_cache_behavior {
    path_pattern     = "/static/*"
    compress         = true
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "expense-dev.sankardevops.shop"
    cache_policy_id  = local.cache_opti_policy
    
   

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    
  }

restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "expense-dev"
  }

  viewer_certificate {
    acm_certificate_arn = local.acm_cert
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method = "sni-only"
  }


  }

  
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = "sankardevops.shop"

  records = [
    {
      name    = "expense-cdn"
      type    = "A"
      alias   = {
        name    = aws_cloudfront_distribution.expense.domain_name
        zone_id = aws_cloudfront_distribution.expense.hosted_zone_id
      }
      
    }
  ]
  

}
