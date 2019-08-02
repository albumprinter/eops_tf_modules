variable "provision" {
  default = true
}

variable "tag_environment" {}

variable "tag_cost_center" {}

variable "tag_domain" {}

variable "tag_others" {
  default = {}
}


## ---------------- Event Rule ----------------
# Conditionally Required
variable "event_rule_event_pattern" {
  default = null
}
variable "event_rule_schedule_expression" {
  default = null
}
# Optional
variable "event_rule_description" {
  default = null
}
variable "event_rule_name" {
  default = null
}
variable "event_rule_name_prefix" {
  default = null
}
variable "event_rule_role_arn" {
  default = null
}
variable "event_rule_is_enabled" {
  default = null
}

## ---------------- Event Target ----------------
# Required
variable "event_target_arn" {}

# Optional
variable "event_target_target_id" {
  default = null
}
variable "event_target_input" {
  default = null
}
variable "event_target_input_path" {
  default = null
}
variable "event_target_role_arn" {
  default = null
}
variable "event_target_input_transformer_input_paths" {
  default = null
}
variable "event_target_input_transformer_input_template" {
  default = null
}
