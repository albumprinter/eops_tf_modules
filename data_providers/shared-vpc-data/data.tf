data "aws_vpc" "working_vpc" {
  tags = {
    Name = "${var.account_type}_vpc"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.working_vpc.id}"
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.working_vpc.id}"

  tags = {
    Name = "public-*"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.working_vpc.id}"

  tags = {
    Name = "private-*"
  }
}

data "aws_subnet" "public" {
  for_each = data.aws_subnet_ids.public.ids
  id       = each.value
}

data "aws_subnet" "private" {
  for_each = data.aws_subnet_ids.private.ids
  id       = each.value
}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}
