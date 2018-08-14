# Description
An example terraform module to build simple application as aws lambda function triggered by .

## Code Example

```hcl-terraform
//CustomerSubscription.EmailChanged
module "lambda_app" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/lambda_function_sns?ref=lambda_sns_8" # for eg. {TAG_VERSION} = v0.3.0
  app_name = "CustomerSubscriptions-EmailChanged-Lambda"
  description = "Lambda function to update CustomerSubscriptions when an EmailChanged event happens"
  handler = "Albumprinter.CustomerSubscriptions.EmailChanged.Lambda::Albumprinter.CustomerSubscriptions.EmailChanged.Lambda.Handler::Handle"
  environment = "${var.environment}"
  runtime = "dotnetcore1.0" // optional default:nodejs | nodejs4.3 | java8 | python2.7 | dotnetcore1.0 | nodejs4.3-edge
  memory_size = "${var.customersubscriptions_emailChanged_lambda_memory}" //optional
  timeout = "30" // optional
  tags_team = "WATSON"
  lambda_bucket_name = "${var.lambda_bucket_name}"
  lambda_sns_subscription_arn = "arn:aws:sns:eu-west-1:179698508378:Albumprinter-Authentication-Messaging-Messages-V1-EmailChanged"
  variables = {
    dummy = ""
  }
}
```