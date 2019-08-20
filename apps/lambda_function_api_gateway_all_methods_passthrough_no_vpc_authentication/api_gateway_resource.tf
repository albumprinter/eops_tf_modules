module "api_gateway_resource" {
  source                                = "../../apps/api_gateway_resource"
  enable                                = "${var.swagger_resource_enable}"
  api_key_required                      = "${var.swagger_api_key_required}"
  api_key                               = "${var.swagger_api_key}"
  resource_path                         = "${var.swagger_resource_path}"
  api_gateway_rest_api_id               = "${aws_api_gateway_rest_api.app.id}"
  api_gateway_rest_api_name             = "${aws_api_gateway_rest_api.app.name}"
  api_gateway_rest_api_root_resource_id = "${aws_api_gateway_rest_api.app.root_resource_id}"
  api_gateway_deployment_stage_name     = "${aws_api_gateway_deployment.app.stage_name}"
  api_gateway_integration_uri           = "${aws_api_gateway_integration.app_integration.uri}"
  api_gateway_integration_credentials   = "${aws_api_gateway_integation.app_integration.credentials}"
  providers = {
    aws = "aws"
  }
}
