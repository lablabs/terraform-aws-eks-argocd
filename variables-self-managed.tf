# IMPORTANT: Add addon specific variables here

variable "self_managed" {
  type        = bool
  default     = true
  description = "If set to true, the module will create ArgoCD Application manifest in the cluster and abandon the Helm release"
  nullable    = false
}

variable "self_managed_helm_release_name" {
  type        = string
  default     = ""
  description = "Helm release name for self-managed installation. Required if `self_managed` is set to `true`."
  nullable    = false
}

variable "self_managed_helm_upgrade_install" {
  type        = bool
  default     = false
  description = "Set to true to enable Helm upgrade with --install flag for self-managed installation. This will install the release if it doesn't exist or upgrade it if it does."
  nullable    = false
}
