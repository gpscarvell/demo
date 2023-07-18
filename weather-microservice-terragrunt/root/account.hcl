# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account = {
    name           = "root"
    aws_account_id = "xxxxxxx"
    aws_profile    = "root"
  }
  company = {
    prefix = "demo"
  }
  jurisdiction = "global"
  alias        = "glbl"
}
