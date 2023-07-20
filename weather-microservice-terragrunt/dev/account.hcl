# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account = {
    name           = "dev2"
    aws_account_id = "818396592856"
    aws_profile    = "dev"
  }
  company = {
    prefix = "demo"
  }
  jurisdiction = "ohio"
  alias        = "oh"
  dns_zone     = "${local.alias}.demo.com"
}

iam_role = "arn:aws:iam::${local.account.aws_account_id}:role/OrganizationAccountAccessRole"
