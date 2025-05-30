# IMPORTANT: Add addon specific variables here
variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
  nullable    = false
}

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

variable "application_controller_service_account_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Application controller Service Account from being created."
}

variable "application_controller_service_account_name" {
  type        = string
  default     = "argocd-application-controller"
  description = "Name of the ArgoCD Application controller Service Account."
  nullable    = false
}

variable "application_controller_irsa_role_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Application controller IRSA role from being created."
  nullable    = false
}

variable "application_controller_irsa_role_name" {
  type        = string
  default     = "argocd-application"
  description = "Name of the ArgoCD Application controller IRSA role."
  nullable    = false
}

variable "application_controller_irsa_additional_policies" {
  type        = map(string)
  default     = {}
  description = "Additional IAM policies to attach to the ArgoCD Application controller IRSA role."
}

variable "applicationset_controller_service_account_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD ApplicationSet controller Service Account from being created."
}

variable "applicationset_controller_service_account_name" {
  type        = string
  default     = "argocd-applicationset-controller"
  description = "Name of the ArgoCD ApplicationSet controller Service Account."
  nullable    = false
}

variable "applicationset_controller_irsa_role_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD ApplicationSet controller IRSA role from being created."
}

variable "applicationset_controller_irsa_role_name" {
  type        = string
  default     = "argocd-applicationset"
  description = "Name of the ArgoCD ApplicationSet controller IRSA role."
  nullable    = false
}

variable "applicationset_controller_irsa_additional_policies" {
  type        = map(string)
  default     = {}
  description = "Additional IAM policies to attach to the ArgoCD ApplicationSet controller IRSA role."
}

variable "notifications_controller_service_account_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Notifications controller Service Account from being created."
}

variable "notifications_controller_service_account_name" {
  type        = string
  default     = "argocd-notifications-controller"
  description = "Name of the ArgoCD Notifications controller Service Account."
  nullable    = false
}

variable "notifications_controller_irsa_role_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Notifications controller IRSA role from being created."
}

variable "notifications_controller_irsa_role_name" {
  type        = string
  default     = "argocd-notifications"
  description = "Name of the ArgoCD Notifications controller IRSA role."
  nullable    = false
}

variable "notifications_controller_irsa_additional_policies" {
  type        = map(string)
  default     = {}
  description = "Additional IAM policies to attach to the ArgoCD Notifications controller IRSA role."
}

variable "server_service_account_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Server Service Account from being created."
}

variable "server_service_account_name" {
  type        = string
  default     = "argocd-server"
  description = "Name of the ArgoCD Server Service Account."
  nullable    = false
}

variable "server_irsa_role_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Server IRSA role from being created."
}

variable "server_irsa_role_name" {
  type        = string
  default     = "argocd-server"
  description = "Name of the ArgoCD Server IRSA role."
  nullable    = false
}

variable "server_irsa_additional_policies" {
  type        = map(string)
  default     = {}
  description = "Additional IAM policies to attach to the ArgoCD Server IRSA role."
}

variable "dex_server_service_account_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Dex Server Service Account from being created."
}

variable "dex_server_service_account_name" {
  type        = string
  default     = "argocd-dex-server"
  description = "Name of the ArgoCD Dex Server Service Account."
  nullable    = false
}

variable "dex_server_irsa_role_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Dex Server IRSA role from being created."
}

variable "dex_server_irsa_role_name" {
  type        = string
  default     = "argocd-dex-server"
  description = "Name of the ArgoCD Dex Server IRSA role."
  nullable    = false
}

variable "dex_server_irsa_additional_policies" {
  type        = map(string)
  default     = {}
  description = "Additional IAM policies to attach to the ArgoCD Dex Server IRSA role."
}

variable "repo_server_service_account_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Repo Server Service Account from being created."
}

variable "repo_server_service_account_name" {
  type        = string
  default     = "argocd-repo-server"
  description = "Name of the ArgoCD Repo Server Service Account."
  nullable    = false
}

variable "repo_server_irsa_role_create" {
  type        = bool
  default     = true
  description = "Set to false to prevent the ArgoCD Repo Server IRSA role from being created."
}

variable "repo_server_irsa_role_name" {
  type        = string
  default     = "argocd-repo-server"
  description = "Name of the ArgoCD Repo Server IRSA role."
  nullable    = false
}

variable "repo_server_irsa_additional_policies" {
  type        = map(string)
  default     = {}
  description = "Additional IAM policies to attach to the ArgoCD Repo Server IRSA role."
}
