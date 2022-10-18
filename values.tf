locals {
  values = yamlencode({
    "controller" : {
      "serviceAccount" : {
        "create" : var.service_account_create_application_controller
        "name": var.service_account_name_application_controller
        "annotations" : {
          "eks.amazonaws.com/role-arn" : local.irsa_role_create ? aws_iam_role.this[0].arn : ""
        }
      }
    }
    "server" : {
      "serviceAccount" : {
        "create": var.service_account_create_server
        "name": var.service_account_name_server
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
