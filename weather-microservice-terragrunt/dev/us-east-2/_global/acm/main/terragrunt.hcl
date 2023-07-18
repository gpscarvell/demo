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
  zone     = local.account_vars.locals.dns_zone
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-acm.git//.?ref=v4.1.0"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependencies {
  paths = [
    find_in_parent_folders("_global/dns/main"),
  ]
}

dependency "zone" {
  config_path = find_in_parent_folders("_global/dns/main")
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  domain_name               = dependency.zone.outputs.route53_zone_name[local.zone]
  subject_alternative_names = ["*.${dependency.zone.outputs.route53_zone_name[local.zone]}"]
  zone_id                   = dependency.zone.outputs.route53_zone_zone_id[local.zone]

  tags = {
    # Define custom tags here as key = "value"
  }
}
