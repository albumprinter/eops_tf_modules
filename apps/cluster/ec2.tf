resource "aws_instance" "app" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = "${var.private == true ? false :true}"
  iam_instance_profile = "${aws_iam_instance_profile.app.name}"
  security_groups = ["${aws_security_group.app.id}"]
  subnet_id = "${element(module.aws_core_data.private_subnets,count.index)}"
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
  key_name = "${var.key_name}"

  tags {
    Name            = "TEST${upper(var.app_name)}00${count.index + 1}.AWS"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
//  provisioner "chef" {
//    environment             = "${var.environment}"
//    run_list                = ["role[main_provisioner]"]
//    node_name               = "main_provisioner"
//    server_url              = "https://${var.chef_server}/organizations/${var.organization}/"
//    secret_key              = "${file(var.provisioner_pem_key)}"
//    user_name               = "${var.chef_client}"
//    user_key                = "${file(var.chef_pem_key)}"
//    fetch_chef_certificates = "${var.fetch_chef_certificates}"
//    recreate_client         = true
//  }

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
    server_url      = "https://chef.albelli.com/organizations/${var.tags_team}"
    recreate_client = false
    user_name       = "${var.tags_team}"
    user_key        = "${var.chef_user_key}"
    version         = "12.4.1"
    connection {
      type = "ssh"
    }
  }
  count = "${var.instance_count}"
}

resource "aws_iam_instance_profile" "app" {
  name  = "${var.app_name}"
  roles = ["${aws_iam_role.app.name}"]
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.0.0/16", "77.60.83.148/32"]
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