module "event_rule" {
  source = "../event_rule"
  provision = var.event_rule_event_pattern != null  || var.event_rule_schedule_expression != null ? true : false

  # Conditionally Required
  event_rule_event_pattern = var.event_rule_event_pattern
  event_rule_schedule_expression = var.event_rule_schedule_expression

  # Optional
  event_rule_description = var.event_rule_description
  event_rule_name = var.event_rule_name != null ? var.event_rule_name : "${var.function_name}"
  event_rule_name_prefix = var.event_rule_name_prefix
  event_rule_role_arn = var.event_rule_role_arn
  event_rule_is_enabled = var.event_rule_is_enabled

  # Required
  event_target_arn = module.lambda_function.function_arn

  # Optional
  event_target_target_id = var.event_target_target_id
  event_target_input = var.event_target_input
  event_target_input_path = var.event_target_input_path
  event_target_role_arn = var.event_target_role_arn
  event_target_input_transformer_input_template = var.event_target_input_transformer_input_template
  event_target_input_transformer_input_paths = var.event_target_input_transformer_input_paths

  #Required
  tag_environment = var.tag_environment
  tag_cost_center = var.tag_cost_center
  tag_domain = var.tag_domain

  #Optional
  tag_others = var.tag_others
}


module "event_rule_lambda_permission" {
  source  = "../../resources/lambda_permission"
  provision = var.event_rule_event_pattern != null  || var.event_rule_schedule_expression != null ? true : false

  # Required
  action = var.lambda_permission_action
  function_name = "${var.function_name}"
  principal = "events.amazonaws.com"

  # Optional
  event_source_token = var.lambda_permission_event_source_token
  qualifier = var.lambda_permission_qualifier
  source_account = var.lambda_permission_source_account
  source_arn = var.lambda_permission_source_arn
  statement_id = var.lambda_permission_statement_id
  statement_id_prefix = var.lambda_permission_statement_id_prefix
}
