output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.my_distrib.domain_name
}
