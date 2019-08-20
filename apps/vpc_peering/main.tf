# Data sources
module "local_data" {
  source = "../../data_providers/local-get-data"

  # See repo for possible outputs
}


provider "aws" {
  region  = "eu-west-1"
  alias   = "source_provider"
  version = "~> 0.1"
  assume_role {
    role_arn = "arn:aws:iam::${var.peer_source_account_id}:role/main_provisioner"
  }
}

data "aws_vpc" "source_vpc_main" {
  provider = "aws.source_provider"
  tags {
    Name = "main"
  }
}

data "aws_caller_identity" "source_account" {
  provider = "aws.source_provider"
}

provider "aws" {
  region  = "eu-west-1"
  alias   = "target_provider"
  version = "~> 0.1"
  assume_role {
    role_arn = "arn:aws:iam::${var.peer_target_account_id}:role/main_provisioner"
  }
}

data "aws_vpc" "target_vpc_main" {
  provider = "aws.target_provider"
  tags {
    Name = "main"
  }
}


data "aws_caller_identity" "target_account" {
  provider = "aws.target_provider"
}
