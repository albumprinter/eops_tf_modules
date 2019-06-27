resource "aws_instance" "app" {
  ami                = "${var.ami}"
  count               = "${var.instance_count}"
  instance_type       = "${var.instance_type}"
  associate_public_ip_address = "${var.private}"
  iam_instance_profile = "${aws_iam_instance_profile.app.id}"
  vpc_security_group_ids     = ["${aws_security_group.app.id}"]
  subnet_id           = "${element(module.aws_core_data.private_subnets,count.index)}"

  tags {
    Domain          = "${var.tags_domain}"
    Name            = "${var.app_name}${count.index + 1}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
    AutoOffOn       = "${var.tags_AutoOffOn}"
    AutoOn          = "${var.tags_AutoOn}"
    AutoOff         = "${var.tags_AutoOff}"
    AutoOnDays      = "${var.tags_AutoOnDays}"
  }
}

# SG for instance
resource "aws_security_group" "app" {
  name        = "EC2-${var.app_name}"
  description = "Allow inbound traffic for ${var.app_name}"
  vpc_id      = "${module.aws_core_data.vpc_id}"
  tags {
    Domain          = "${var.tags_domain}"
    Name            = "${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}

resource "aws_iam_instance_profile" "app" {
  name = "EC2-${var.app_name}"
  roles = ["${aws_iam_role.app.id}"]
}

resource "aws_iam_role" "app" {
  name = "EC2-${var.app_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}