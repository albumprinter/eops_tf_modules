resource "aws_api_gateway_api_key" "api_key" { 
  name          = "${var.api_gateway_rest_api_name}_${var.resource_path}" 
  value         = "${var.api_key}"
  count         = "${var.enable > 0 && var.api_key_required > 0 ? 1  : 0}"
} 
 
resource "aws_api_gateway_usage_plan" "usage_plan" { 
  name     = "${var.api_gateway_rest_api_name}_${var.resource_path}" 
  api_stages { 
    api_id = "${var.api_gateway_rest_api_id}" 
    stage  = "${var.api_gateway_deployment_stage_name}" 
  } 
  count    = "${var.enable > 0 && var.api_key_required > 0 ? 1  : 0}"
} 
 
resource "aws_api_gateway_usage_plan_key" "usage_plan_key" { 
  key_id        = "${aws_api_gateway_api_key.api_key[0].id}" 
  key_type      = "API_KEY" 
  usage_plan_id = "${aws_api_gateway_usage_plan.usage_plan[0].id}" 
  count         = "${var.enable > 0 && var.api_key_required > 0 ? 1  : 0}" 
} 