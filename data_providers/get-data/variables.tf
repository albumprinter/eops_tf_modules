variable "region" {
  default = "eu-west-1"
}

variable "vpc_name" {
  default = "main"
}

# dev, tst, acc or prd
variable "environment" {
  default = "dev"
}

# sandbox, non-prod or prod
variable "type" {
  default = "sandbox"
}

variable "tags_business_unit" {
  default = "Albumprinter"
}

variable "tags_cost_center" {
  default = "CC443100"
}

variable "tags_purpose" {
  default = ""
}

variable "tags_team" {
  default = ""
}

variable "tags_contact" {
  default = ""
}

variable "tags_description" {
  default = ""
}
