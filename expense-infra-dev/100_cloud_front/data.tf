data "aws_cloudfront_cache_policy" "default" {
  name = "Managed-CachingDisabled"
}
data "aws_cloudfront_cache_policy" "optimized" {
  name = "Managed-CachingOptimized"
}
data "aws_ssm_parameter" "aws_cert"{
    name ="/expense/dev/aws_cert"

} 
