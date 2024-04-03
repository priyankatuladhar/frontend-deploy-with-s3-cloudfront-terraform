output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.priyanka-example-presentation-layer.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.priyanka-example-presentation-layer.arn
}

# output "bucket_arn" {
#   description = "The ARN of the S3 bucket"
#   value       = aws_s3_bucket.priyanka-example-presentation-layer.arn
# }

# output "bucket_name" {
#   value = aws_s3_bucket.priyanka-example-presentation-layer.bucket
# }
# output "bucket_domain_name" {
#   value = aws_s3_bucket.priyanka-example-presentation-layer.bucket_regional_domain_name
# }