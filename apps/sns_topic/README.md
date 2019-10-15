## Module usage
This module will setup an SNS topic with the correct security policies for you.
````hcl-terraform
module "sns_enrichment_cloud_shippingcomplete" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/sns_topic"
  app_name = "Enrichment-ToTheCloud-ShippingComplete-Topic"
  description = "SNS Topic for shipping complete lambda"
  environment = "${var.environment}"
  iam_policy_document = "" // empty string so that ternary in module validates
  tags_cost_center = "${var.cost_center}"
  tags_domain = "Enrichment"
  tags_team = "${var.tags_team}"
  tags_purpose = "Enrichment"
  providers = {
    aws = "aws"
  }
}
````