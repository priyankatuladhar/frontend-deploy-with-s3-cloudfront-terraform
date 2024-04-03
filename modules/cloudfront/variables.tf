variable "domain_origin" {
  description = "The domain name of the S3 bucket or any other origin"
  type        = string
}
variable "s3_origin_id" {
  description = "A unique identifier for the origin"
  type        = string
}
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
variable "s3_bucket_name" {
  description = "A value to pass from s3 to cloudfront"
  type        = string
}
variable "oai_path" {
  description = "The CloudFront Origin Access Identity path"
  type        = string
}
variable "stage" {
  description = "stage value"
  type        = string
  default     = "priyanka"
}

variable "name" {
  description = "name value"
  type        = string
  default     = "cloudfront"
}

variable "additional_tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}