locals {
  irsa_role_create = var.enabled && length([for sa in values(var.service_accounts)[*] : sa if sa.create]) > 0 && var.irsa_role_create
}

data "aws_iam_policy_document" "this_irsa" {
  count = local.irsa_role_create ? 1 : 0

  dynamic "statement" {
    for_each = { for component, attributes in var.service_accounts : component => attributes if attributes.create }

    content {
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [var.cluster_identity_oidc_issuer_arn]
      }

      condition {
        test     = "StringEquals"
        variable = "${replace(var.cluster_identity_oidc_issuer, "https://", "")}:sub"

        values = [
          "system:serviceaccount:${var.namespace}:${statement.value.name}"
        ]
      }

      effect = "Allow"
    }
  }
}

resource "aws_iam_role" "this" {
  count              = local.irsa_role_create ? 1 : 0
  name               = "${var.irsa_role_name_prefix}-${var.helm_chart_name}"
  assume_role_policy = data.aws_iam_policy_document.this_irsa[0].json
  tags               = var.irsa_tags
}

resource "aws_iam_role_policy_attachment" "this_additional" {
  for_each = local.irsa_role_create ? var.irsa_additional_policies : {}

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}
