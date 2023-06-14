output "vpc_id" {
  value = "${data.aws_vpc.working_vpc.id}"
}

output "all_subnet_ids" {
  value = data.aws_subnets.all.ids
}

output "public_subnet_ids" {
  value = data.aws_subnets.public.ids
}

output "private_subnet_ids" {
  value = data.aws_subnets.private.ids
}
output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "availability_zones" {
  value = "${data.aws_availability_zones.available.names}"
}

output "public_subnets" {
  value = [for s in data.aws_subnets.public : s.id]
}

output "private_subnets" {
  value = [for s in data.aws_subnets.private : s.id]
}