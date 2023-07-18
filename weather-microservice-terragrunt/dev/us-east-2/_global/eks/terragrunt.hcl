# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path           = "${find_in_parent_folders("_envcommon/eks/cluster")}//terragrunt.hcl"
  expose         = true
  merge_strategy = "deep"
}

# inputs will be merged with _envcommon/eks/cluster inputs
inputs = {
  helm_charts = {
    prometheus = {
      name       = "prometheus"
      namespace  = "monitoring"
      repository = "https://prometheus-community.github.io/helm-charts"
      chart      = "prometheus"
      version    = "18.1.1"

      values = [
        templatefile("prometheus-values.yaml", {}),
      ]
    }
  }
}
