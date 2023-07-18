
resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argocd"
  }
}



resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argo"
  version    = "4.9.7"  # Specify the version of Argo CD you want to install

  values = [
  ]

  depends_on = [kubernetes_namespace.argo]
}


