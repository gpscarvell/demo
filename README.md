1)  This demo uses terragrunt to wrap terraform, to setup terragrunt you will need to edit the standard account.hcl, region.hcl and terragrunt.hcl files to reflect your AWS account, region and profile.
2)  The build-env.sh will deploy the terragrunt/terraform once step one is complete; the build-env.sh will also deploy argocd, Jenkins and the demo weather application.
