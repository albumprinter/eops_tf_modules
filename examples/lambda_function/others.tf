module "security_group" {
  source = "../../resources/security_group"
  
  name = "eops_tf_modules_example_lambda_function"
  vpc_id = data.aws_vpc.main.id
  egress_rules = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Domain = "ci-cd platform"
    "Cost Center" = "303100"
    Environment = "test"
  }
}
