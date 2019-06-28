locals {
  tags = merge({
    Domain        = var.tag_domain
    Enviroment    = var.tag_environment
    "Cost Center" = var.tag_cost_center
  }, var.tag_others)
}
