## ---------------- Custom ----------------
variable "provision" {
  default = true
}
variable "tag_environment" {}

variable "tag_cost_center" {}

variable "tag_domain" {}

## ---------------- API Gateway REST API ----------------
# Required
variable "api_gateway_rest_api_name" {
  default = null
}

# Optional
variable "api_gateway_rest_api_description" {
  default = null
}
variable "api_gateway_rest_api_endpoint_configuration_types" {
  default = ["EDGE"]
}
variable "api_gateway_rest_api_binary_media_types" {
  default = null
}
variable "api_gateway_rest_api_minimum_compression_size" {
  default = null
}
variable "api_gateway_rest_api_body" {
  default = null
}
variable "api_gateway_rest_api_policy" {
  default = null
}
variable "api_gateway_rest_api_api_key_source" {
  default = null
}

## ---------------- API Gateway Resource ----------------
# Required
variable "api_gateway_resource_path_part" {
  default = null
}

## ---------------- API Gateway Method ----------------
# Required
variable "api_gateway_method_http_method" {
  default = "ANY"
}
variable "api_gateway_method_authorization" {
  default = "NONE"
}

# Optional
variable "api_gateway_method_authorizer_id" {
  default = null
}
variable "api_gateway_method_authorization_scopes" {
  default = null
}
variable "api_gateway_method_api_key_required" {
  default = null
}
variable "api_gateway_method_request_models" {
  default = null
}
variable "api_gateway_method_request_validator_id" {
  default = null
}
variable "api_gateway_method_request_parameters" {
  default = null
}

## ---------------- API Gateway Integration ----------------
# Required
variable "api_gateway_integration_http_method" {
  default = "ANY"
}
variable "api_gateway_integration_type" {
  default = "AWS_PROXY"
}

# Optional
variable "api_gateway_integration_integration_http_method" {
  default = "POST"
}
variable "api_gateway_integration_connection_type" {
  default = null
}
variable "api_gateway_integration_connection_id" {
  default = null
}
variable "api_gateway_integration_uri" {
  default = null
}
variable "api_gateway_integration_credentials" {
  default = null
}
variable "api_gateway_integration_request_templates" {
  default = null
}
variable "api_gateway_integration_request_parameters" {
  default = null
}
variable "api_gateway_integration_passthrough_behavior" {
  default = null
}
variable "api_gateway_integration_cache_key_parameters" {
  default = null
}
variable "api_gateway_integration_cache_namespace" {
  default = null
}
variable "api_gateway_integration_content_handling" {
  default = null
}
variable "api_gateway_integration_timeout_milliseconds" {
  default = null
}

## ---------------- API Gateway Deployment ----------------
# Optional
variable "api_gateway_deployment_stage_name" {
  default = null
}
variable "api_gateway_deployment_description" {
  default = null
}
variable "api_gateway_deployment_stage_description" {
  default = null
}
variable "api_gateway_deployment_variables" {
  type = "map"
  default = null
}