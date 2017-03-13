provider "aws" {
  region = "${var.region}"
}

module "aws_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_core_data?ref=v0.1.10"
}

# Create a new load balancer
resource "aws_elb" "load_balancer" {
  name            = "${var.load_balancer_name}"
  subnets         = ["${module.aws_core_data.public_subnets}"]
  security_groups = ["${aws_security_group.sg_elb.id}"]
  instances       = ["${aws_instance.app.*.id}"]

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "${var.lb_protocol}"
  }

  health_check {
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.timeout}"
    target              = "${var.target}"
    interval            = "${var.interval}"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 300

  tags {
    Name            = "${var.load_balancer_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}

# SG for ELB
resource "aws_security_group" "sg_elb" {
  name        = "SG-${var.load_balancer_name}"
  description = "Allow inbound traffic for ELB"
  vpc_id      = "${module.aws_core_data.vpc_id}"

  ingress {
    from_port   = "${var.lb_port}"
    to_port     = "${var.lb_port}"
    protocol    = "${var.sg-protocol}"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# SG for instance
resource "aws_security_group" "sg_application" {
  name        = "SG-${var.application_name}"
  description = "Allow inbound traffic for ${var.application_name}"
  vpc_id      = "${module.aws_core_data.vpc_id}"

  ingress {
    from_port   = "${var.instance_port}"
    to_port     = "${var.instance_port}"
    protocol    = "${var.sg-protocol}"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# instance
resource "aws_instance" "app" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.sg_application.id}", "${var.ssh_sg}"]
  subnet_id              = "${element(module.aws_core_data.private_subnets, count.index % length(module.aws_core_data.private_subnets))}"
  key_name               = "${var.key_name}"
  user_data              = "${var.user_data}"

  count = "${var.servers}"

  tags {
    Name            = "${var.application_name}-${count.index}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}
