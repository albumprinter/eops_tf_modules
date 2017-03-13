# Description
An example terraform module to build simple application.

## Code Example

```hcl-terraform
module "app_name" {
  source             = "git@github.com:albumprinter/eops_tf_modules.git//apps/sample_loadbalanced_application?ref=v0.1.10"
  load_balancer_name = "app_name"
  lb_port            = "80"
  lb_protocol        = "http"
  tags_purpose       = "Terraform Demo"
  description        = "Terraform Demo"
  environment        = "dev"
  application_name   = "app_name"
  ami_id             = "ami-405f7226"
  key_name           = "${aws_key_pair.deployer.key_name}"
  servers            = 2
  ssh_sg             = "${aws_security_group.sg_ssh.id}"
}
```
