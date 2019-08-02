module "event_rule" {
  source  = "../../resources/cloudwatch_event_rule"
  provision = var.provision

  # Required
  tags = local.tags

  # Conditionally Required
  event_pattern       = var.event_rule_event_pattern
  schedule_expression = var.event_rule_schedule_expression

  # Optional
  description = var.event_rule_description
  name        = var.event_rule_name
  name_prefix = var.event_rule_name_prefix
  role_arn    = var.event_rule_role_arn
  is_enabled  = var.event_rule_is_enabled
}

module "event_target" {
  source  = "../../resources/cloudwatch_event_target"
  provision = ((var.event_rule_event_pattern != null  || var.event_rule_schedule_expression != null) && var.event_target_input_transformer_input_template == null) ? true : false

  # Required
  arn  = var.event_target_arn
  rule = module.event_rule.event_rule_name

  # Optional
  target_id                         = var.event_target_target_id
  input                             = var.event_target_input
  input_path                        = var.event_target_input_path
  role_arn                          = var.event_target_role_arn
}

module "event_target_input_transformer" {
  source  = "../../resources/cloudwatch_event_target_input_transformer"
  provision = ((var.event_rule_event_pattern != null  || var.event_rule_schedule_expression != null) && var.event_target_input_transformer_input_template != null) ? true : false

  # Required
  arn  = var.event_target_arn
  rule = module.event_rule.event_rule_name

  # Optional
  target_id                         = var.event_target_target_id
  input                             = var.event_target_input
  input_path                        = var.event_target_input_path
  role_arn                          = var.event_target_role_arn
  input_transformer_input_paths     = var.event_target_input_transformer_input_paths
  input_transformer_input_template  = var.event_target_input_transformer_input_template
}