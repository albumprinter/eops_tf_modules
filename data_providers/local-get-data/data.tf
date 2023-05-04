# Data sources
data "aws_vpc" "main" {
  tags = {
    Name = "main"
  }
}

data "aws_vpc" "default_vpc" {
  default = "true"
}



data "aws_caller_identity" "current" {}

data "aws_availability_zones" "availability_zones" {}

data "aws_subnet" "public" {
  vpc_id = "${data.aws_vpc.main.id}"
  availability_zone = "${element(sort(data.aws_availability_zones.availability_zones.names), count.index)}"

  tags = {
    Name = "public-*"
  }

  count = "2"
}

data "aws_subnet" "private" {
  vpc_id = "${data.aws_vpc.main.id}"
  availability_zone = "${element(sort(data.aws_availability_zones.availability_zones.names), count.index)}"

  tags = {
    Name = "private-*"
  }

  count = "2"
}

data "aws_route_table" "public" {
  vpc_id = "${data.aws_vpc.main.id}"
  tags = {
    Name = "*-public"
  }
}

data "aws_route_table" "private" {
  vpc_id = "${data.aws_vpc.main.id}"
  subnet_id = "${element(sort(data.aws_subnet.private.*.id), count.index)}"

  count = "2"
}

data "aws_vpn_gateway" "vpn_gateway" {
  attached_vpc_id = "${data.aws_vpc.main.id}"
}

data "aws_route_table" "default_vpc_route_table" {
  vpc_id = "${data.aws_vpc.default_vpc.id}"
}