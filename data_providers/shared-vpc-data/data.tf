data "aws_vpc" "working_vpc" {
  tags = {
    Name = "${var.account_type}_vpc"
  }
}

data "aws_subnets" "all" {
  vpc_id = "${data.aws_vpc.working_vpc.id}"
}

data "aws_subnets" "public" {
  vpc_id = "${data.aws_vpc.working_vpc.id}"
  tags = {
    Tier = "public-*"
  }
}

data "aws_subnets" "private" {
  vpc_id = "${data.aws_vpc.working_vpc.id}"
  tags = {
    Tier = "private-*"
  }
}

data "aws_subnet" "public" {
  count = "${length(data.aws_subnets.public.ids)}"
  id    = "${data.aws_subnets.public.ids[count.index]}"
}

data "aws_subnet" "private" {
  count = "${length(data.aws_subnets.private.ids)}"
  id    = "${data.aws_subnets.private.ids[count.index]}"
}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}