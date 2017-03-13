## Synopsis

A set of core terraform modules for standardized infrastructure provisioning across multi-account life-cycles.

## Code Example

In order to provision the example standardized setup, create a terraform git repo and make sure it is registered 
as a jenkins infra terraform multi aws account lifecycles project.

```hcl-terraform
module "app_name" {
  source             = "git@github.com:albumprinter/eops_tf_modules.git//apps/sample_loadbalanced_application?ref=v0.1.10"
  description        = "Terraform Demo"
  environment        = "dev"
  application_name   = "app_name"
  ami_id             = "ami-405f7226"
  servers            = 2
}
```

To get access to the core-infrastructure data (vpc's, subnets, regions, tags):
```hcl-terraform
module "aws_account_core_data" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//data_providers/aws_account_core_data"
}
```
