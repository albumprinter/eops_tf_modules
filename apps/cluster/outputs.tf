# ELB
output "elb_address" {
  value = "${aws_elb.bar.dns_name}"
}

output "sg_elb_id"  {
  value = "${aws_security_group.app_elb.id}"
}

# Instances
output "sg_instance_id"  {
  value = "${aws_security_group.app.id}"
}

output "instance_id"  {
  value = ["${aws_instance.app.*.id}"]
}

output "instance_ip"  {
  value = ["${aws_instance.app.*.private_ip}"]
}
