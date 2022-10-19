locals {
  values = yamlencode({
    "controller" : {
      "serviceAccount" : {
        "create" : var.service_accounts.controller.create
        "name" : var.service_accounts.controller.name
        "annotations" : {
          "eks.amazonaws.com/role-arn" : local.irsa_role_create ? aws_iam_role.this[0].arn : ""
        }
      }
    }
    "server" : {
      "serviceAccount" : {
        "create" : var.service_accounts.server.create
        "name" : var.service_accounts.server.name
        "annotations" : {
          "eks.amazonaws.com/role-arn" : local.irsa_role_create ? aws_iam_role.this[0].arn : ""
        }
      }
    }
  })
}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    local.values,
    var.values
  ])
}
