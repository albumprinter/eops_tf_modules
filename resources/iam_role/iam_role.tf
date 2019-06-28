resource "aws_iam_role" "role" {
  # Required
  assume_role_policy = templatefile("${path.module}/templates/assume_role_policy.tpl", {
    principal_type   = var.assume_role_principal_type,
    principal_target = var.assume_role_principal
  })

  # Optional
  description           = var.description
  force_detach_policies = var.force_detach_policies
  max_session_duration  = var.max_session_duration
  name                  = var.name
  name_prefix           = var.name_prefix
  path                  = var.path
  permissions_boundary  = var.permissions_boundary
  tags                  = var.tags
}

resource "aws_iam_policy" "policy" {
  # Required
  policy = templatefile("${path.module}/templates/permissions_policy.tpl", {
    policy_statements = var.policy_statements
  })

  # Optional
  description = var.policy_description
  name        = var.policy_name
  name_prefix = var.policy_name_prefix
  path        = var.policy_path
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}