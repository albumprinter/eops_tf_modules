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
variable "tags_domain" {}
variable "tags_purpose" {
  default = ""
}
variable "description" {}

variable "environment" {}

variable "app_name" {
  description = "A value to append to the RDS identifer to create a unique name"
  default = "rds-database"
}

variable "enabled" {
  default = 1
}

variable "db_storage_size" {
  default = 10
}

variable "db_engine_version" {
  default = "5.6.22"
}

variable "db_instance_size" {
  default = "db.t2.micro"
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
  default = "06:00-07:00"
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