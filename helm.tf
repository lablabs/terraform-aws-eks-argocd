locals {
  self_managed_enabled = var.enabled && var.argo_enabled == true && var.self_managed
}

resource "helm_release" "self_managed" {
  count = local.self_managed_enabled ? 1 : 0

  chart            = var.helm_chart_name != null ? var.helm_chart_name : try(local.addon.helm_chart_name, local.addon.name)
  create_namespace = var.helm_create_namespace != null ? var.helm_create_namespace : try(local.addon.helm_create_namespace, true)
  namespace        = local.addon_namespace
  name             = var.self_managed_helm_release_name
  version          = var.helm_chart_version != null ? var.helm_chart_version : try(local.addon.helm_chart_version, null)
  repository       = var.helm_repo_url != null ? var.helm_repo_url : try(local.addon.helm_repo_url, null)

  repository_key_file        = var.helm_repo_key_file != null ? var.helm_repo_key_file : try(local.addon.helm_repo_key_file, "")
  repository_cert_file       = var.helm_repo_cert_file != null ? var.helm_repo_cert_file : try(local.addon.helm_repo_cert_file, "")
  repository_ca_file         = var.helm_repo_ca_file != null ? var.helm_repo_ca_file : try(local.addon.helm_repo_ca_file, "")
  repository_username        = var.helm_repo_username != null ? var.helm_repo_username : try(local.addon.helm_repo_username, "")
  repository_password        = var.helm_repo_password != null ? var.helm_repo_password : try(local.addon.helm_repo_password, "")
  devel                      = var.helm_devel != null ? var.helm_devel : try(local.addon.helm_devel, false)
  verify                     = var.helm_package_verify != null ? var.helm_package_verify : try(local.addon.helm_package_verify, false)
  keyring                    = var.helm_keyring != null ? var.helm_keyring : try(local.addon.helm_keyring, "~/.gnupg/pubring.gpg")
  timeout                    = var.helm_timeout != null ? var.helm_timeout : try(local.addon.helm_timeout, 300)
  disable_webhooks           = var.helm_disable_webhooks != null ? var.helm_disable_webhooks : try(local.addon.helm_disable_webhooks, false)
  reset_values               = var.helm_reset_values != null ? var.helm_reset_values : try(local.addon.helm_reset_values, false)
  reuse_values               = var.helm_reuse_values != null ? var.helm_reuse_values : try(local.addon.helm_reuse_values, false)
  force_update               = var.helm_force_update != null ? var.helm_force_update : try(local.addon.helm_force_update, false)
  recreate_pods              = var.helm_recreate_pods != null ? var.helm_recreate_pods : try(local.addon.helm_recreate_pods, false)
  cleanup_on_fail            = var.helm_cleanup_on_fail != null ? var.helm_cleanup_on_fail : try(local.addon.helm_cleanup_on_fail, false)
  max_history                = var.helm_release_max_history != null ? var.helm_release_max_history : try(local.addon.helm_release_max_history, 0)
  atomic                     = var.helm_atomic != null ? var.helm_atomic : try(local.addon.helm_atomic, false)
  wait                       = var.helm_wait != null ? var.helm_wait : try(local.addon.helm_wait, false)
  wait_for_jobs              = var.helm_wait_for_jobs != null ? var.helm_wait_for_jobs : try(local.addon.helm_wait_for_jobs, false)
  skip_crds                  = var.helm_skip_crds != null ? var.helm_skip_crds : try(local.addon.helm_skip_crds, false)
  render_subchart_notes      = var.helm_render_subchart_notes != null ? var.helm_render_subchart_notes : try(local.addon.helm_render_subchart_notes, true)
  disable_openapi_validation = var.helm_disable_openapi_validation != null ? var.helm_disable_openapi_validation : try(local.addon.helm_disable_openapi_validation, false)
  dependency_update          = var.helm_dependency_update != null ? var.helm_dependency_update : try(local.addon.helm_dependency_update, false)
  replace                    = var.helm_replace != null ? var.helm_replace : try(local.addon.helm_replace, false)
  description                = var.helm_description != null ? var.helm_description : try(local.addon.helm_description, "")
  lint                       = var.helm_lint != null ? var.helm_lint : try(local.addon.helm_lint, false)

  values = compact([
    var.values
  ])

  dynamic "set" {
    for_each = var.settings != null ? var.settings : try(local.addon.settings, tomap({}))

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.helm_set_sensitive != null ? var.helm_set_sensitive : try(local.addon.helm_set_sensitive, {})

    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  dynamic "postrender" {
    for_each = var.helm_postrender != null ? var.helm_postrender : try(local.addon.helm_postrender, {})

    content {
      binary_path = postrender.value
    }
  }

  lifecycle {
    ignore_changes = all
  }
}
