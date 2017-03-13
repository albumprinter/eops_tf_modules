# Description
An example terraform module to build simple application as aws lambda function triggered by cloudwatch event scheduleder.

## Code Example

```hcl-terraform
module "lambda_app" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/lambda_function_scheduled?ref=v0.1.10"
  app_name = ""
  description = ""
  handler = ""
  filename = ""
  schedule_expression = "rate(5 minutes)" // optional For example, "rate(5 minutes)" or "cron(0 20 * * ? *)"
  environment = ""
  variables = "" // optional
  runtime = "dotnetcore1.0" // optional default:nodejs | nodejs4.3 | java8 | python2.7 | dotnetcore1.0 | nodejs4.3-edge
  memory_size = "128" //optional
  timeout = "3" // optional 
  enabled = 1 // optional avail options: 1 | 0
  private = false // optional
}
```