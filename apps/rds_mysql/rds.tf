resource "aws_security_group" "database" {
  name        = "${var.environment}-${var.app_name}"
  description = "RDS database security group"

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

  vpc_id = "${module.aws_core_data.vpc_id}"
}

resource "aws_security_group_rule" "db_ingress" {
  type              = "ingress"
  security_group_id = "${aws_security_group.database.id}"
  description       = "Allow access to the database"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["${var.db_cidr}"]
}
resource "aws_security_group_rule" "db_egress" {
  security_group_id = "${aws_security_group.database.id}"
  description       = "Allow all outgoing"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_db_subnet_group" "database" {
  name        = "${var.environment}-${var.app_name}"
  description = "RDS subnet group"
  subnet_ids  = flatten([module.aws_core_data.private_subnets])
}

resource "aws_db_instance" "database" {
  name = "${var.app_name}"
  //  depends_on = ["aws_db_subnet_group.database", "aws_security_group.database"]
  identifier                = "${var.environment}-${var.app_name}"
  allocated_storage         = "${var.db_storage_size}"
  engine                    = "mysql"
  engine_version            = "${var.db_engine_version}"
  instance_class            = "${var.db_instance_size}"
  username                  = "${var.db_admin_username}"
  password                  = "${var.db_admin_password}"
  db_subnet_group_name      = "${aws_db_subnet_group.database.name}"
  parameter_group_name      = "${var.db_parameter_group}"
  final_snapshot_identifier = "${var.environment}-${var.app_name}"
  backup_retention_period   = "${var.db_backup_retention_period}"
  backup_window             = "${var.db_backup_window}"
  maintenance_window        = "${var.db_maintenance_window}"
  multi_az                  = "${var.db_multi_az}"
  vpc_security_group_ids    = ["${aws_security_group.database.id}"]
  publicly_accessible       = false
  lifecycle {
    prevent_destroy = true
  }

  copy_tags_to_snapshot     = true
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
