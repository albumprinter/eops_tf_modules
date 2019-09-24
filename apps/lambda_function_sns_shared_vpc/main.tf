provider "aws" {
}

module "aws_shared_data" {
  source = "../../data_providers/shared-vpc-data"
  account_type = "${var.account_type}"
  providers = {
    aws = "aws"
  }
}
