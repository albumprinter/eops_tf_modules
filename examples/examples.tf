provider "aws" {
  region = "eu-west-1"
}

module "lambda_function" {
  source = "./lambda_function"  
}
