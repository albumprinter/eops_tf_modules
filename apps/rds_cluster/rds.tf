#---------------------------------------------------
# Create AWS RDS instance(s)
#---------------------------------------------------
resource "aws_db_instance" "db_instance" {
  count                     = "${var.create_rds_instance ? 1 : 0}"
  identifier                = "${lower(var.name)}-rds-${lower(var.environment)}"
  allocated_storage         = "${var.allocated_storage}"
  storage_type              = "${var.storage_type}"
  iops                      = "${var.iops}"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine_version}"
  instance_class            = "${var.instance_class}"
  replicate_source_db       = "${var.replicate_source_db}"
  backup_retention_period   = "${var.backup_retention_period}"
  backup_window             = "${var.backup_window}"
  copy_tags_to_snapshot     = "${var.copy_tags_to_snapshot}"
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "${lower(var.name)}-rds-${lower(var.environment)}-${md5(timestamp())}"

  name               = "${var.db_name}"
  username           = "${var.db_username}"
  password           = "${local.master_password}"
  port               = "${lookup(var.default_ports, var.engine)}"
  character_set_name = "${var.character_set_name}"

  vpc_security_group_ids = ["${aws_security_group.db_security_group.id}"]
  db_subnet_group_name   = "${var.db_subnet_group_name == "" ? aws_db_subnet_group.db_subnet_group.name : var.db_subnet_group_name}"
  parameter_group_name   = "${length(var.parameter_group_name) > 0 ? var.parameter_group_name : aws_db_parameter_group.db_parameter_group.id}"
  publicly_accessible    = "${var.publicly_accessible}"
  storage_encrypted      = "${var.storage_encrypted}"
  multi_az               = "${var.db_multi_az}"
  deletion_protection    = "${var.deletion_protection}"

  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  maintenance_window          = "${var.maintenance_window}"

  monitoring_interval                 = "${var.monitoring_interval}"
  iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"

  tags = "${merge(
    map(
      "Name", "${lower(var.name)}-rds-${lower(var.environment)}",
      "Description", "${lower(var.name)}-rds-${lower(var.environment)}  aws_db_instance ${var.description}"
    ),
    local.common_tags
  )}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["final_snapshot_identifier", "replicate_source_db"]
  }

  depends_on = ["aws_db_subnet_group.db_subnet_group", "aws_db_parameter_group.db_parameter_group"]
}

#---------------------------------------------------
# Create AWS RDS cluster
#---------------------------------------------------
resource "aws_rds_cluster_instance" "rds_cluster_instance" {
  count = "${var.create_rds_cluster ? var.number_of_instances_in_the_cluster : 0}"

  identifier         = "${lower(var.name)}-cluster-${lower(var.environment)}-${count.index + 1}"
  cluster_identifier = "${aws_rds_cluster.rds_cluster.id}"
  instance_class     = "${var.instance_class}"

  db_subnet_group_name    = "${var.db_subnet_group_name == "" ? aws_db_subnet_group.db_subnet_group.name : var.db_subnet_group_name}"
  apply_immediately       = "${var.apply_immediately}"
  db_parameter_group_name = "${var.instance_parameter_group_name}"

  tags = "${merge(
    map(
      "Name", "${lower(var.name)}-cluster-${lower(var.environment)}-${count.index + 1}",
      "Description", "${lower(var.name)}-cluster-${lower(var.environment)}-${count.index + 1} ${var.description}"
    ),
    local.common_tags
  )}"

  depends_on = ["aws_rds_cluster.rds_cluster", "aws_db_subnet_group.db_subnet_group", "aws_db_parameter_group.db_parameter_group"]
}

resource "aws_rds_cluster" "rds_cluster" {
  count = "${var.create_rds_cluster ? 1 : 0}"

  cluster_identifier = "${lower(var.name)}-cluster-${lower(var.environment)}"
  engine             = "${var.engine}"
  engine_version     = "${var.engine_version}"
  # engine_mode        = "${var.engine_mode}"

  backup_retention_period   = "${var.backup_retention_period}"
  preferred_backup_window   = "${var.backup_window}"
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "${lower(var.name)}-cluster-${lower(var.environment)}-${md5(timestamp())}"

  db_subnet_group_name   = "${var.db_subnet_group_name == "" ? aws_db_subnet_group.db_subnet_group.name : var.db_subnet_group_name}"
  vpc_security_group_ids = ["${aws_security_group.db_security_group.id}"]

  storage_encrypted               = "${var.storage_encrypted}"
  apply_immediately               = "${var.apply_immediately}"
  db_cluster_parameter_group_name = "${var.db_cluster_parameter_group_name}"
  availability_zones              = ["${split(",", (lookup(var.availability_zones, var.region)))}"]

  database_name                       = "${var.db_name}"
  master_username                     = "${var.db_username}"
  master_password                     = "${local.master_password}"
  iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"

  tags = "${merge(
    map(
      "Name", "${lower(var.name)}-cluster-${lower(var.environment)}",
      "Description", "${lower(var.name)}-cluster-${lower(var.environment)} ${var.description}"
    ),
    local.common_tags
  )}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["final_snapshot_identifier"]
  }

  depends_on = ["aws_db_subnet_group.db_subnet_group", "aws_db_parameter_group.db_parameter_group"]
}

resource "aws_rds_cluster" "serverless_cluster" {
  count = "${var.create_serverless_cluster ? 1 : 0}"

  cluster_identifier = "${lower(var.name)}-cluster-${lower(var.environment)}"
  engine_mode        = "serverless"

  backup_retention_period   = "${var.backup_retention_period}"
  preferred_backup_window   = "${var.backup_window}"
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "${lower(var.name)}-cluster-${lower(var.environment)}-${md5(timestamp())}"

  db_subnet_group_name   = "${var.db_subnet_group_name == "" ? aws_db_subnet_group.db_subnet_group.name : var.db_subnet_group_name}"
  vpc_security_group_ids = ["${aws_security_group.db_security_group.id}"]

  storage_encrypted  = "${var.storage_encrypted}"
  apply_immediately  = "${var.apply_immediately}"
  availability_zones = ["${split(",", (lookup(var.availability_zones, var.region)))}"]

  database_name   = "${var.db_name}"
  master_username = "${var.db_username}"
  master_password = "${local.master_password}"
  # iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"

  scaling_configuration {
    auto_pause               = "${var.serverless_cluster_auto_pause}"
    min_capacity             = "${var.serverless_cluster_min_capacity}"
    max_capacity             = "${var.serverless_cluster_max_capacity}"
    seconds_until_auto_pause = "${var.serverless_cluster_suap}"
  }

  tags = "${merge(
    map(
      "Name", "${lower(var.name)}-cluster-${lower(var.environment)}",
      "Description", "${lower(var.name)}-cluster-${lower(var.environment)} ${var.description}"
    ),
    local.common_tags
  )}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["final_snapshot_identifier", "engine_version"]
  }

  depends_on = ["aws_db_subnet_group.db_subnet_group"]
}

#---------------------------------------------------
# Create AWS DB security group
#---------------------------------------------------
resource "aws_security_group" "db_security_group" {
  name        = "${lower(var.name)}-db-security-group-for-${lower(var.environment)}"
  description = "RDS database security group"
  vpc_id      = "${var.vpc_id == "" ? module.aws_core_data.vpc_id : var.vpc_id}"

  ingress {
    from_port       = "${lookup(var.default_ports, var.engine)}"
    to_port         = "${lookup(var.default_ports, var.engine)}"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.allow_db_access.id}", "${var.allowed_db_access_sg_groups}"]
  }

  ingress {
    from_port   = "${lookup(var.default_ports, var.engine)}"
    to_port     = "${lookup(var.default_ports, var.engine)}"
    protocol    = "tcp"
    cidr_blocks = ["${var.private_cidr_blocks}"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    map(
      "Name", "${lower(var.name)}-db-security-group-for-${lower(var.environment)}",
      "Description", "${lower(var.name)}-db-security-group-for-${lower(var.environment)} ${var.description}"
    ),
    local.common_tags
  )}"
  depends_on = ["aws_security_group.allow_db_access"]
}

resource "aws_security_group" "allow_db_access" {
  name        = "${lower(var.name)}-allow-db-access-security-group-${lower(var.environment)}"
  description = "Allow to connect to RDS database"
  vpc_id      = "${var.vpc_id == "" ? module.aws_core_data.vpc_id : var.vpc_id}"

  tags = "${merge(
    map(
      "Name", "${lower(var.name)}-allow-db-access-security-group-${lower(var.environment)}",
      "Description", "${lower(var.name)}-allow-db-access-security-group-${lower(var.environment)} ${var.description}"
    ),
    local.common_tags
  )}"
}

#---------------------------------------------------
# Create AWS DB subnet group
#---------------------------------------------------
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${lower(var.name)}-db-subnet-group-for-${var.create_rds_cluster ? "cluster" : "rds"}-${lower(var.environment)}"
  description = "My ${lower(var.name)}-db_subnet_group-for-${var.create_rds_cluster ? "cluster" : "rds"}-${lower(var.environment)} group of subnets"
  subnet_ids  = ["${split(",", join(",", module.aws_core_data.private_subnets))}"]

  tags = "${merge(
    map(
      "Name", "${lower(var.name)}-db-subnet-group-for-${lower(var.environment)}",
      "Description", "${lower(var.name)}-db-subnet-group-for-${lower(var.environment)} ${var.description}"
    ),
    local.common_tags
  )}"
}

#---------------------------------------------------
# Create AWS DB parameter group
#---------------------------------------------------
resource "aws_db_parameter_group" "db_parameter_group" {
  count = "${length(var.parameter_group_name) > 0 ? 0 : 1}"

  name        = "${lower(var.name)}-db-parameter-group-for-${var.create_rds_cluster ? "cluster" : "rds"}-${lower(var.environment)}"
  description = "RDS ${lower(var.name)}-db_parameter_group-for-${var.create_rds_cluster ? "cluster" : "rds"}-${lower(var.environment)} parameter group for ${var.engine}"
  family      = "${length(var.db_parametergroup_family) > 0 ? var.db_parametergroup_family : var.db_group_family[var.engine]}"
  parameter   = "${var.default_db_parameters[var.engine]}"

  tags = "${merge(
    map(
      "Name", "${lower(var.name)}-db_parameter_group-${lower(var.environment)}"
    ),
    local.common_tags
  )}"
}
