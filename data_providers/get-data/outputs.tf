output "vpc_id" {
  value = "${data.terraform_remote_state.terraform-ap.vpc_id}"
}

output "vpc_cidr" {
  value = "${data.terraform_remote_state.terraform-ap.vpc_cidr}"
}

output "public_subnets" {
  value = ["${data.terraform_remote_state.terraform-ap.public_subnets}"]
}

output "private_subnets" {
  value = ["${data.terraform_remote_state.terraform-ap.private_subnets}"]
}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "tags_business_unit" {
  value = "${var.tags_business_unit}"
}

output "tags_environment" {
  value = "${var.environment}"
}

output "tags_type" {
  value = "${var.type}"
}

output "tags_cost_center" {
  value = "${var.tags_cost_center}"
}

output "tags_purpose" {
  value = "${var.tags_purpose}"
}

output "tags_team" {
  value = "${var.tags_team}"
}

output "tags_contact" {
  value = "${var.tags_contact}"
}

output "tags_description" {
  value = "${var.tags_description}"
}
