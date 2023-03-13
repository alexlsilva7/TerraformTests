resource "aws_s3_bucket" "first_bucket" {
  bucket = "alexlsilva-remote-state"
  tags = {
    Name = "first_bucket"
  }
  versioning {
    enabled = true
  }
}

