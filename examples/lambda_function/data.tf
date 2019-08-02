data "aws_vpc" "main" {
  tags = {
    Name = "sandbox_vpc"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags = {
    Name = "private*"
  }
}