# Data sources
data "terraform_remote_state" "terraform-ap" {
  backend = "s3"

  config {
    bucket = "terraform-ap"
    key    = "${data.aws_caller_identity.current.account_id}/core-infra/terraform.tfstate"
    region = "eu-west-1"
    acl    = "bucket-owner-full-control"
  }
}

data "aws_availability_zones" "available" {}

data "aws_vpc" "main" {
  tags {
    Name = "${var.vpc_name}"
  }
}

data "aws_caller_identity" "current" {}
