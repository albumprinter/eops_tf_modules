resource "aws_instance" "app" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
  associate_public_ip_address = "${var.private == true ? false :true}"
  iam_instance_profile = ""
//  subnet_id = ""
  vpc_security_group_ids = []

  tags {
    Name            = "${var.app_name}-${count.index + 1}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }

  provisioner "chef" {
    attributes_json = <<-EOF
      {
          "key": "value",
      }
      EOF

    environment     = "${var.environment}"
    run_list        = "${var.chef_run_list}"
    node_name       = "${var.app_name}-${count.index + 1}"
    secret_key      = "${file("../encrypted_data_bag_secret")}"
    server_url      = "https://chef.albelli.com/organizations/${var.tags_team}"
    recreate_client = false
    user_name       = "${var.tags_team}"
    user_key        = "${file("../${var.tags_team}.pem")}"
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