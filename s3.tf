resource "null_resource" "remove_and_upload_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync ${path.module}/website s3://${aws_s3_bucket.bucket.id}"
  }
}
resource "aws_s3_bucket" "bucket" {
  bucket = "s3web.devopsstudy.tech"
  acl    = "public-read"
  policy = file("policy.json")

   website {
    index_document = "index.html"
    error_document = "error.html"
}

  tags = {
    Name        = "s3web.devopsstudy.tech"
  }
}
output "site-url" {
    value = aws_s3_bucket.bucket.website_endpoint
}
