terraform {
  backend "s3" {
    bucket = "tf-complex-cloud-state"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}
