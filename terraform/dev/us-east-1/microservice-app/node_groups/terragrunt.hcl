# ---------------------------------------------------------------------------------------------------------------------
# Include configurations that are common used across multiple environments.
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path           = "${find_in_parent_folders("_envcommon/eks/managed_node_group")}//terragrunt.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  create = true

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]
  desired_size   = 2
  max_size       = 3
  min_size       = 1

  tags = {
    "service" = "api"
  }
}
