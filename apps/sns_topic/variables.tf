variable "region" {
  default = "eu-west-1"
}
variable "app_name" {
}
variable "iam_policy_document" {
    default = ""
}
variable "environment" {}
variable "description" {}

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

variable "sns_extra_policy_statements"
{
  default = ""
}