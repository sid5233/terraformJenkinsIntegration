provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "mytucchiu"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "tfHome_TfDB"
  }
}