locals {
  cache_default_policy = data.aws_cloudfront_cache_policy.default.id
  cache_opti_policy   = data.aws_cloudfront_cache_policy.optimized.id
  acm_cert            = data.aws_ssm_parameter.aws_cert.value
}
