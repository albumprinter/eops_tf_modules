# Create a new load balancer
resource "aws_elb" "bar" {

  name            = "ELB-${var.app_name}"
  subnets         = ["${element(module.aws_core_data.public_subnets,0)}", "${element(module.aws_core_data.public_subnets,1)}"]
  security_groups = ["${aws_security_group.app_elb.id}"]

  listener {
    instance_port     = "${var.instance_port_inside}"
    instance_protocol = "${var.instance_protocol_inside}"
    lb_port           = "${var.lb_port_outside}"
    lb_protocol       = "${var.lb_protocol_outside}"
      }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.elb_healthcheck_target}"
    interval            = 30
  }


  instances                   = ["${aws_instance.app.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Domain          = "${var.tags_domain}"
    Name            = "ELB-${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }

}

# SG for loadbalancer
resource "aws_security_group" "app_elb" {
  name        = "SG-ELB-${var.app_name}"
  description = "Allow inbound traffic for ${var.app_name}"
  vpc_id      = "${module.aws_core_data.vpc_id}"

  ingress {
    from_port   = "${var.ec2_sg_ingress_fromport}"
    to_port     = "${var.ec2_sg_ingress_toport}"
    protocol    = "${var.ec2_sg_ingress_protocol}"
    cidr_blocks = "${var.SG_elb_cidr_blocks}"

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
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