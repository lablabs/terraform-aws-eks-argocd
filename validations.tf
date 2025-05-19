resource "terraform_data" "validations" {
  lifecycle {
    precondition {
      condition     = !local.self_managed_enabled || var.self_managed_helm_release_name != ""
      error_message = "The `self_managed_helm_release_name` variables must be set when self-managed installation is enabled."
    }
  }
}
