output "db_endpoint" {
  value = "${aws_db_instance.database.endpoint}"
}

output "db_id" {
  value = "${aws_db_instance.database.id}"
}

output "security_group_id" {
  value = "${aws_security_group.database.id}"
}

output "db_admin_username" {
  value = "${aws_db_instance.database.username}"
}

output "db_admin_password" {
  sensitive = true
  value = "${aws_db_instance.database.password}"
}