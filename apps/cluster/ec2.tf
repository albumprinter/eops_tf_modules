resource "aws_instance" "app" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
//  associate_public_ip_address = "${var.private == true ? false :true}"
  iam_instance_profile = "${aws_iam_instance_profile.app.name}"
  subnet_id = "${element(module.aws_core_data.private_subnets,count.index)}"
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
  key_name = "${var.key_name}"


  tags {
    Name            = "${upper(var.environment)}-${upper(var.app_name)}00${count.index + 1}-AWS"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }


  provisioner "chef" {
//    attributes_json = <<-EOF
//      {
//          "key": "value",
//      }
//      EOF

    environment     = "${var.environment}"
    run_list        = "${var.chef_run_list}"
    node_name       = "${var.app_name}-${count.index + 1}"
//    secret_key      = "${file("../encrypted_data_bag_secret")}"
    server_url      = "${var.chef_serverurl}${var.tags_team}"
    recreate_client = true
    user_name       = "${var.tags_team}"
    user_key        = "${file("${var.user_keypath}")}"
    version         = "${var.chef_client_version}"

    fetch_chef_certificates = true
    connection {
      type = "ssh"
      user="ubuntu"
      private_key = "${file("${var.private_keypath}")}"
      host = "${self.private_ip}"
    }
  }
  count = "${var.instance_count}"
}

resource "aws_iam_instance_profile" "app" {
  name  = "${var.app_name}"
  roles = ["${aws_iam_role.app.name}"]

  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "aws_iam_role" "app" {
  name = "${var.app_name}"
  path = "/"

  assume_role_policy = "${var.iam_policy_document}"
}

# SG for instance
resource "aws_security_group" "app" {
  name        = "SG-${var.app_name}"
  description = "Allow inbound traffic for ${var.app_name}"
  vpc_id      = "${module.aws_core_data.vpc_id}"

  ingress {
    from_port   = "${var.ec2_sg_ingress_fromport}"
    to_port     = "${var.ec2_sg_ingress_toport}"
    protocol    = "${var.ec2_sg_ingress_protocol}"
    cidr_blocks = "${var.SG_cidr_blocks}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name            = "${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}