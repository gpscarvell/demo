1)  This demo uses terragrunt to wrap terraform, to setup terragrunt you will need to edit the standard account.hcl, region.hcl and terragrunt.hcl files to reflect your AWS account, region and profile.
2)  The build-env.sh will deploy the terragrunt/terraform once step one is complete; the build-env.sh will also deploy argocd.
3)  A commit to the branch will trigger the github action CI to perform the following pipeline steps
    
    `a) Checkout`  
    
    `b) Build Dockerfile`  
    
    `c) Push image to ecr`  
    
    `d) Update the image tag in the values file which will trigger argocd to deploy the application` 
