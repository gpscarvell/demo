locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))


  # Extract out common variables for reuse
  env_name = local.environment_vars.locals.environment.name
  account  = local.account_vars.locals.account
  prefix   = local.account_vars.locals.company.prefix
  region   = local.region_vars.locals.region
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "${get_parent_terragrunt_dir()}/components//vpn"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependencies {
  paths = [
    find_in_parent_folders("network/sg/vpn"),
    find_in_parent_folders("vpn/resolver"),
  ]
}

dependency "sg" {
  config_path = find_in_parent_folders("network/sg/vpn")
}

dependency "resolver" {
  config_path = find_in_parent_folders("vpn/resolver")
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name = "non-prod-vpn"

  authentication_type = "certificate-authentication"

  cidr                = "10.2.0.0/16"
  allowed_cidr_ranges = ["0.0.0.0/0"]
  security_group_ids  = [dependency.sg.outputs.security_group_id]
  dns_servers         = dependency.resolver.outputs.ip_addresses
  organization_name   = "arbonne-dev"
  split_tunnel        = true

  enable_self_service_portal = true

  subnet_ids = ["subnet-025919c0bee929146"]
  vpc_id     = "vpc-0ac4a6f5455e24838"

  # Mapping between AWS Accounts and VPC CIDR ranges
  vpn_routes = {
    "on-nonprod"  = "10.11.0.0/16"
  }

  # Certificates managed with emails
  client_certs = [
    "geoffrey.scarvell@gmail.com",
  ]

  tags = {
    # Define custom tags here as key = "value"
  }
}
