module "argocd_disabled" {
  source = "../../"

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  enabled = false
}

module "argocd_helm" {
  source = "../../"

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  enabled           = true
  argo_enabled      = false
  argo_helm_enabled = false

  self_managed = false

  helm_release_name = "argocd"
  namespace         = "argocd"

  helm_timeout = 240
  helm_wait    = true

}

module "argocd_self_managed_kubernetes" {
  source = "../../"

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = false

  self_managed = true

  helm_release_name = "argocd-kubernetes"
  namespace         = "argocd-kubernetes"

  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}

module "argocd_self_managed_helm" {
  source = "../../"

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = true

  self_managed = true

  helm_release_name = "argocd-helm"
  namespace         = "argocd-helm"

  argo_namespace = "argo"
  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}
