resource "aws_s3_bucket" "application-code" {
    bucket = "web-app-tier-application-code"
    tags = {
        Name = "Three tier application-code"
    }
}

# Upload the entire folder to S3 using AWS CLI
resource "null_resource" "upload_files" {
  provisioner "local-exec" {
    command = "aws s3 cp ./modules/s3/application-code/ s3://${aws_s3_bucket.application-code.bucket}/ --recursive"
  }

  # Ensure the null resource runs after the bucket is created
  depends_on = [aws_s3_bucket.application-code]
}