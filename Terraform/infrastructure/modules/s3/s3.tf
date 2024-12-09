resource "aws_s3_bucket" "application-code" {
    bucket = "web-app-tier-application-code"
    tags = {
        Name = "Three tier application-code"
    }
}
