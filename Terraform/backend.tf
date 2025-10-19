terraform {
  backend "s3" {
    bucket  = "terraform-state-verivi"
    key     = "site/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}