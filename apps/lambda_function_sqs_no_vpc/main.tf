provider "aws" {
  region = "${var.region}"
}
provider "aws" { 
  region = "${var.region}" 
  alias = "default" 
  version = "~> 1.0" 
}
module "aws_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
  providers = { 
    aws = "aws.default" 
  }
}
