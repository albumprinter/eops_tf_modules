resource "aws_vpc_peering_connection" "vpc_peering" {
  provider = "aws.source_provider"

  peer_vpc_id = "${data.aws_vpc.target_vpc_main.id}"
  vpc_id = "${data.aws_vpc.source_vpc_main.id}"
  peer_owner_id = "${data.aws_caller_identity.target_account.account_id}"

//  the requester setup block does not work in Terraform v0.10.4 or lower.
//  It is included here so you can uncomment when it works.  In the mean time
//  see the readme for work around
//  requester {
//    allow_remote_vpc_dns_resolution = "${var.allow_remote_vpc_dns_resolution}"
//  }

  tags {
    Domain = "${var.tags_domain}"
    Name = "${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center" = "${var.tags_cost_center}"
    Team = "${var.tags_team}"
    Purpose = "${var.tags_purpose}"
    Description = "${var.description}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "source_vpc_peer_route_table" {
  provider = "aws.source_provider"
  depends_on = [
    "aws_vpc_peering_connection.vpc_peering"]

  vpc_id = "${data.aws_vpc.source_vpc_main.id}"

  route {
    cidr_block = "${data.aws_vpc.target_vpc_main.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering.id}"
  }

  tags {
    Domain = "${var.tags_domain}"
    Name = "${var.app_name}-route"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center" = "${var.tags_cost_center}"
    Team = "${var.tags_team}"
    Purpose = "${var.tags_purpose}"
    Description = "${var.description}"
    Environment = "${var.environment}"
  }
}

