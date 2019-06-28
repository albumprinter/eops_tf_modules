variable "function_handler" {
  default = "index.handler"
}
variable "function_runtime" {
  default = "nodejs8.10"
}
variable "function_s3_bucket" {
  default = "eops-prod-builds"
}
variable "function_s3_key" {
  default = "builds/lambda/boilerplate/node_boilerplate.zip"
}
variable "iam_role_policy_statements" {
  default = [
    {
      "Effect" : "Allow",
      "Action" : [
        "s3:ListBucket"
      ],
      "Resource" : ["*"]
    }
  ]
}
variable "tag_cost_center" {
  default = "303100"
}
variable "tag_environment" {
  default = "test"
}
variable "tag_domain" {
  default = "ci-cd platform"
}
