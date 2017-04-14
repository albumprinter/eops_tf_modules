# Data sources

data "terraform_remote_state" "terraform-ap" {
  backend = "s3"

  config {
//    bucket = "${var.terraform_bucket}"
    bucket = "eops-sandbox"
    key    = "${data.aws_caller_identity.current.account_id}/core-infra/terraform.tfstate"
    region = "eu-west-1"
    acl    = "bucket-owner-full-control"
  }
}

// For local development:
//data "terraform_remote_state" "terraform-ap" {
//  backend = "local"
//  config {
//    path = "${path.cwd}/data_providers/aws_account_core_data/dataterraform.tfstate"
//  }
//}

data "aws_availability_zones" "available" {}

data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

data "aws_vpc" "main" {
  tags {
    Name = "main"
  }
}

data "aws_caller_identity" "current" {}
