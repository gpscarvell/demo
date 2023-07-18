# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path           = "${find_in_parent_folders("_envcommon/eks/rbac")}//terragrunt.hcl"
  expose         = true
  merge_strategy = "deep"
}

# inputs will be merged with _envcommon/eks/rbac inputs
inputs = {
   namespaces = ["${include.envcommon.locals.account_vars.locals.alias}-cicd"]

   role_rules = [
     {
       api_groups = [""]
       verbs      = ["get", "list", "watch"]
       resources  = ["*"]
     },
     {
       api_groups = ["extensions"]
       verbs      = ["get", "list", "watch"]
       resources  = ["*"]
     },
     {
       api_groups = ["apps"]
       verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
       resources  = ["*"]
     }
   ]
}
