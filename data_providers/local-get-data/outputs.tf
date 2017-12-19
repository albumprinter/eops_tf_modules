# Outputs
output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "availability_zones" {
  value = "${data.aws_availability_zones.availability_zones.names}"
}

output "vpc_id" {
  value = "${data.aws_vpc.main.id}"
}

output "vpc_cidr" {
  value = "${data.aws_vpc.main.cidr_block}"
}

output "public_subnets" {
  value = ["${data.aws_subnet.public.*.id}"]
}

output "public_subnet_a" {
  value = "${data.aws_subnet.public.0.id}"
}

output "private_subnets" {
  value = ["${data.aws_subnet.private.*.id}"]
}

output "public_route_table" {
  value = "${data.aws_route_table.public.id}"
}

output "private_route_tables" {
  value = ["${data.aws_route_table.private.*.id}"]
}

output "vpn_gateway" {
  value = "${data.aws_vpn_gateway.vpn_gateway.id}"
}

output "default_vpc_id" {
  value = "${data.aws_vpc.default_vpc.id}"
}

output "default_vpc_route_table_id" {
  value = "${data.aws_route_table.default_vpc_route_table.route_table_id}"
}