provider "aws" {
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.73.0"
}

module "aws_shared_data" {
  source = "../../data_providers/shared-vpc-data"
  account_type = "${var.account_type}"
  providers = {
    aws = "aws"
  }
}
