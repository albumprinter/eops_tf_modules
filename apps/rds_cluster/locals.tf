locals {
  common_tags = {
    Domain          = "${var.tags_domain}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Environment     = "${var.environment}"
    Orchestration   = "${var.orchestration}"
    "Created By"    = "${var.createdby}"
  }

  master_password = "${var.db_password == "" ? random_id.master_password.b64 : var.db_password}"
}

# Random string to use as master password unless one is specified
resource "random_id" "master_password" {
  byte_length = 10
}
