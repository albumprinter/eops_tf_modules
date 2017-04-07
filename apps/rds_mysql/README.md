# Description
An example terraform module to build simple application as aws lambda function triggered by cloudwatch event scheduleder.

## Code Example

```hcl-terraform
module "rds" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/rds_mysql?ref=EOPS-3610"
//  source = "../eops_tf_modules/apps/rds_mysql"
  app_name = "rds"
  tags_cost_center = "CC443100"
  tags_team = "eops"
  description = "The rds for some app"
  enabled = 1
  account_type = "${var.account_type}"
  environment = "${var.environment}"
  db_admin_password = "${var.db_admin_password}"
  db_admin_username = "${var.db_admin_username}"
  db_multi_az = "${var.db_multi_az}"
}
```