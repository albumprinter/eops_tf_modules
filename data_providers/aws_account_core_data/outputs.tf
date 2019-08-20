# output "vpc_id" {
#   value = "${data.terraform_remote_state.terraform-ap.vpc_id}"
# }

# output "vpc_cidr" {
#   value = "${data.terraform_remote_state.terraform-ap.vpc_cidr}"
# }

# output "availability_zones" {
#   value = "${data.aws_availability_zones.available.names}"
# }

# output "public_subnets" {
#   value = "${data.terraform_remote_state.terraform-ap.public_subnets}"
# }

# output "private_subnets" {
#   value = "${data.terraform_remote_state.terraform-ap.private_subnets}"
# }

# output "account_id" {
#   value = "${data.aws_caller_identity.current.account_id}"
# }
# output "tags_environment" {
#   value = "${var.environment}"
# }

# output "tags_type" {
#   value = "${var.type}"
# }
