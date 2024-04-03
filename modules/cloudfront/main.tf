resource "aws_cloudfront_origin_access_control" "cloudfront_s3_oac" {
  name                              = "CloudFront ${var.stage}_${var.name}"
  description                       = "Cloud Front S3 OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
#----s3 data and output-----
data "aws_s3_bucket" "s3" {
  bucket = "priyanka-tf-test-bucket"
}

output "s3_bucket_output" {
  value = data.aws_s3_bucket.s3.bucket
}

#-----------


#-----------cloudfront distribution---------#

resource "aws_cloudfront_distribution" "my_distrib" {

  depends_on = [
    data.aws_s3_bucket.s3,
    aws_cloudfront_origin_access_control.cloudfront_s3_oac
  ]

  origin {
    domain_name              = "${data.aws_s3_bucket.s3.id}.s3.amazonaws.com"
    origin_id                = data.aws_s3_bucket.s3.id
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_s3_oac.id

  }

  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = data.aws_s3_bucket.s3.id


    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }


  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = merge(
    var.additional_tags, {
      Environment = "production"
      Name        = "Priyanka Cloudfront"
      Creator     = "priyankatuladharmail@gmail.com"
      Deletable   = "Yes"
      Project     = "Intern"
  })

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

#-------s3bucket-policies------#
resource "aws_s3_bucket_policy" "origin" {

  depends_on = [
    aws_cloudfront_distribution.my_distrib
  ]
  bucket = data.aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.origin.json
}
#--------Policy----------#
data "aws_iam_policy_document" "origin" {
  depends_on = [
    aws_cloudfront_distribution.my_distrib,
    data.aws_s3_bucket.s3
  ]
  statement {
    sid    = "10"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type        = "Service"
    }
    resources = [
      "arn:aws:s3:::${data.aws_s3_bucket.s3.id}/",
      "arn:aws:s3:::${data.aws_s3_bucket.s3.id}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.my_distrib.arn
      ]
    }
  }
}