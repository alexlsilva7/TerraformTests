terraform {
  backend "s3" {
    bucket = "alexlsilva-remote-state"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}