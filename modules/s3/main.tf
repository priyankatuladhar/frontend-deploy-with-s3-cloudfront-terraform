
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "priyanka-example-presentation-layer" {
  bucket = "priyanka-tf-test-bucket"

  tags = {
    Name        = "My bucket Priyanka"
    Environment = "Dev"

  }
}
resource "aws_s3_object" "object" {
  
  bucket   = aws_s3_bucket.priyanka-example-presentation-layer.id
  key      = each.value
  
  content_type = lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
    "json" = "application/json",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "svg"  = "image/svg+xml"
  }, element(split(".", basename(each.value)), length(split(".", basename(each.value))) - 1), "binary/octet-stream")

  for_each = fileset("/home/priyanka/todolist/Frontend/dist", "**/*")
  source = "/home/priyanka/todolist/Frontend/dist/${each.value}"
}