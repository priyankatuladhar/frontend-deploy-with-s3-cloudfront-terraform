module "priyanka-example-presentation-layer" {
  source = "./modules/s3"
}


output "bucket_id" {
  value = module.priyanka-example-presentation-layer.bucket_id
}

output "bucket_arn" {
  value = module.priyanka-example-presentation-layer.bucket_arn
}

module "my_distrib" {
  source         = "./modules/cloudfront/"
  s3_origin_id   = "module.priyanka-example-presentation-layer.bucket_arn"
  s3_bucket_name = "module.priyanka-example-presentation-layer.bucket_name"
  domain_origin  = "module.priyanka-example-presentation-layer.bucket_regional_name"
  oai_path       = "aws_cloudfront_origin_access_identity.s3_oai.cloudfront_access_identity_path"
}

module "cloudflare" {
  source      = "./modules/cloudflare"
  domain_name = "priyankatuladhar.com.np"
  cloudfront_domain_name = module.cloudfront.cloudfront_domain
}