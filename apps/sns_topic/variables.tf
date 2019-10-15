variable "region" {
  default = "eu-west-1"
}
variable "app_name" {
}
variable "environment" {}
variable "description" {}

variable "iam_policy_document" {
  default = local.iam_policy_document
}

# tags
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {}
variable "tags_team" {}
variable "tags_domain" {}
variable "tags_purpose" {
  default = ""
}
# end tags

variable "sns_extra_policy_statements" {
  default = ""
}