/**
 * # AWS EKS ArgoCD Terraform module
 *
 * A Terraform module to deploy the https://argo-cd.readthedocs.io/en/stable on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-argocd/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-argocd/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-argocd/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-argocd/actions/workflows/pre-commit.yaml)
 */
locals {
  addon = {
    name      = "argocd"
    namespace = "argo"

    helm_chart_name    = "argo-cd"
    helm_chart_version = "7.8.23" # 2.14.9
    helm_repo_url      = "https://argoproj.github.io/argo-helm"
  }

  addon_irsa = {
    "${local.addon.name}-application-controller" = {
      service_account_create   = var.application_controller_service_account_create
      service_account_name     = var.application_controller_service_account_name
      irsa_role_create         = var.application_controller_irsa_role_create
      irsa_role_name           = "application"
      irsa_additional_policies = var.application_controller_irsa_additional_policies
    }
    "${local.addon.name}-applicationset-controller" = {
      service_account_create   = var.applicationset_controller_service_account_create
      service_account_name     = var.applicationset_controller_service_account_name
      irsa_role_create         = var.applicationset_controller_irsa_role_create
      irsa_role_name           = "applicationset"
      irsa_additional_policies = var.applicationset_controller_irsa_additional_policies
    }
    "${local.addon.name}-notifications-controller" = {
      service_account_create   = var.notifications_controller_service_account_create
      service_account_name     = var.notifications_controller_service_account_name
      irsa_role_create         = var.notifications_controller_irsa_role_create
      irsa_role_name           = "notification"
      irsa_additional_policies = var.notifications_controller_irsa_additional_policies
    }
    "${local.addon.name}-server" = {
      service_account_create   = var.server_service_account_create
      service_account_name     = var.server_service_account_name
      irsa_role_create         = var.server_irsa_role_create
      irsa_role_name           = "server"
      irsa_additional_policies = var.server_irsa_additional_policies
    }
    "${local.addon.name}-dex-server" = {
      service_account_create   = var.dex_server_service_account_create
      service_account_name     = var.dex_server_service_account_name
      irsa_role_create         = var.dex_server_irsa_role_create
      irsa_role_name           = "dex-server"
      irsa_additional_policies = var.dex_server_irsa_additional_policies
    }
    "${local.addon.name}-repo-server" = {
      service_account_create   = var.repo_server_service_account_create
      service_account_name     = var.repo_server_service_account_name
      irsa_role_create         = var.repo_server_irsa_role_create
      irsa_role_name           = "repo-server"
      irsa_additional_policies = var.repo_server_irsa_additional_policies
    }
  }

  addon_values = yamlencode({
    controller = {
      serviceAccount = {
        create = local.addon_irsa["${local.addon.name}-application-controller"].service_account_create
        name   = local.addon_irsa["${local.addon.name}-application-controller"].service_account_name
        annotations = module.addon-irsa["${local.addon.name}-application-controller"].irsa_role_enabled ? {
          "eks.amazonaws.com/role-arn" = module.addon-irsa["${local.addon.name}-application-controller"].iam_role_attributes.arn
        } : tomap({})
      }
    }
    applicationSet = {
      serviceAccount = {
        create = local.addon_irsa["${local.addon.name}-applicationset-controller"].service_account_create
        name   = local.addon_irsa["${local.addon.name}-applicationset-controller"].service_account_name
        annotations = module.addon-irsa["${local.addon.name}-applicationset-controller"].irsa_role_enabled ? {
          "eks.amazonaws.com/role-arn" = module.addon-irsa["${local.addon.name}-applicationset-controller"].iam_role_attributes.arn
        } : tomap({})
      }
    }
    notifications = {
      serviceAccount = {
        create = local.addon_irsa["${local.addon.name}-notifications-controller"].service_account_create
        name   = local.addon_irsa["${local.addon.name}-notifications-controller"].service_account_name
        annotations = module.addon-irsa["${local.addon.name}-notifications-controller"].irsa_role_enabled ? {
          "eks.amazonaws.com/role-arn" = module.addon-irsa["${local.addon.name}-notifications-controller"].iam_role_attributes.arn
        } : tomap({})
      }
    }
    server = {
      serviceAccount = {
        create = local.addon_irsa["${local.addon.name}-server"].service_account_create
        name   = local.addon_irsa["${local.addon.name}-server"].service_account_name
        annotations = module.addon-irsa["${local.addon.name}-server"].irsa_role_enabled ? {
          "eks.amazonaws.com/role-arn" = module.addon-irsa["${local.addon.name}-server"].iam_role_attributes.arn
        } : tomap({})
      }
    }
    dex = {
      serviceAccount = {
        create = local.addon_irsa["${local.addon.name}-dex-server"].service_account_create
        name   = local.addon_irsa["${local.addon.name}-dex-server"].service_account_name
        annotations = module.addon-irsa["${local.addon.name}-dex-server"].irsa_role_enabled ? {
          "eks.amazonaws.com/role-arn" = module.addon-irsa["${local.addon.name}-dex-server"].iam_role_attributes.arn
        } : tomap({})
      }
    }
    repoServer = {
      serviceAccount = {
        create = local.addon_irsa["${local.addon.name}-repo-server"].service_account_create
        name   = local.addon_irsa["${local.addon.name}-repo-server"].service_account_name
        annotations = module.addon-irsa["${local.addon.name}-repo-server"].irsa_role_enabled ? {
          "eks.amazonaws.com/role-arn" = module.addon-irsa["${local.addon.name}-repo-server"].iam_role_attributes.arn
        } : tomap({})
      }
    }
  })
}
