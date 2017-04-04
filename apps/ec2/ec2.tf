resource "aws_instance" "app" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = "${var.private == true ? false :true}"
  iam_instance_profile = "${aws_iam_instance_profile.app.name}"
  security_groups = ["${aws_security_group.app.id}"]
  subnet_id = "${element(module.aws_core_data.private_subnets,count.index)}"
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
}

# SG for instance
resource "aws_security_group" "app" {
  name        = "SG-${var.app_name}"
  description = "Allow inbound traffic for ${var.app_name}"
  vpc_id      = "${module.aws_core_data.vpc_id}"
  tags {
    Name            = "${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"sdfaasdf
  }
}