data "aws_vpc" "main" {
  tags = {
    Name = "main"
  }
}

data "aws_security_group" "default" {
  name = "default"

  vpc_id = "${data.aws_vpc.main.id}"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags = {
    Name = "private*"
  }
}