variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {
  default = "CC443100"
}
variable "tags_team" {}
variable "tags_purpose" {
  default = ""
}
variable "description" {}
variable "app_name" {}


variable "environment" {}
variable "variables" {
  default = ""
}

variable "enabled" {
  default = 1
}




variable "admin_cidrs" {
  description = "The CIDR blocks that represent admin IPS. Must be comma separated"
}

variable "product" {
  description = "The product the VPC relates to. This is a logical group of all resources"
  default = "testing"
}

variable "project" {
  description = "The project this VPC relates to. This is a sub-grouping in a project."
  default = "main"
}

variable "db_storage_size" {
  default = 10
}

variable "db_engine_version" {
  default = "5.6.22"
}

variable "db_instance_size" {
  default = "db.t1.micro"
}

variable "db_admin_username" {
  description = "The database admin username"
  default = "rds_admin"
}

variable "db_admin_password" {
  description = "The database admin password"
}

variable "db_parameter_group" {
  description = "The name of the parameter group for the database"
  default = "default.mysql5.6"
}

variable "db_backup_window" {
  description = "The time period in which to backup the database"
  default = "08:00-09:00"
}

variable "db_maintenance_window" {
  description = "The time period in which to run maintenance on the database"
  default = "sun:07:00-sun:07:30"
}

variable "db_multi_az" {
  description = "Set whether the database should be multi AZ"
  default = true
}

variable "db_backup_retention_period" {
  description = "The database retention period"
  default = 7
}

variable "db_engine" {
  description = "Database engine to use for the RDS instance"
  default = "mysql"
}

variable "db_identifer_suffix" {
  description = "A value to append to the RDS identifer to create a unique name"
  default = "rds-database"
}