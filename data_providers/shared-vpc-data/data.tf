data "aws_vpc" "working_vpc" {
  tags = {
    Name = "${var.account_type}_vpc"
  }
}

data "aws_subnets" "all" {
   filter {
    name   = "vpc-id"
    values = [data.aws_vpc.working_vpc.id]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.working_vpc.id]
  }
  tags = {
    Tier = "public-*"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.working_vpc.id]
  }
  tags = {
    Tier = "private-*"
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}