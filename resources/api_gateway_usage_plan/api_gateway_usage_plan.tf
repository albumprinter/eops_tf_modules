resource "aws_api_gateway_usage_plan" "plan" {
  count = var.provision == true ? 1 : 0

  # Required
  name = var.name

  # Optional
  description = var.description
  api_stages {
    api_id = var.api_stages_api_id
    stage = var.api_stages_stage
  }
  quota_settings {
    limit = var.quota_settings_limit
    offset = var.quota_settings_offset
    period = var.quota_settings_period 
  }
  throttle_settings {
    burst_limit = var.throttle_settings_burst_limit
    rate_limit = var.throttle_settings_rate_limit
  }
  product_code = var.product_code
}