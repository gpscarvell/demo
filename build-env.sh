#!/bin/bash


function deployTerragrunt() {

	currentdir=`pwd`

	cd weather-microservice-terragrunt/dev/_global/iam/policy/cicd terraform-composition/dev/_global/iam/policy/developer terraform-composition/dev/_global/iam/policy/deny_state terraform-composition/dev/_global/iam/policy/qa terraform-composition/dev/_global/iam/policy/sre terraform-composition/dev/_global/iam/policy/sysadmin

	terragrunt apply --terragrunt-non-interactive

######

	cd ${currentdir}

	cd weather-microservice-terragrunt/dev/_global/iam/role/cicd terraform-composition/dev/_global/iam/role/developer terraform-composition/dev/_global/iam/role/eks-managed-node terraform-composition/dev/_global/iam/role/qa terraform-composition/dev/_global/iam/role/sre terraform-composition/dev/_global/iam/role/sysadmin

	terragrunt apply --terragrunt-non-interactive

#######

	cd ${currentdir}

	cd weather-microservice-terragrunt/_global/kms

	terragrunt apply --terragrunt-non-interactive

######

	cd ${currentdir}

	cd weather-microservice-terragrunt/dev/us-west-1/_global/eks

	terragrunt apply --terragrunt-non-interactive
   
#####

	cd ${currentdir}

	cd weather-microservice-terragrunt/dev/us-west-1/dev/node_groups

	terragrunt apply --terragrunt-non-interactive

}


function deployArgocd() {

	cd ${currentdir}
	
	cd weather-microservice-argocd

	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

  cd jenkins
  kubectl apply -n argocd -f argocd-jenkins.yaml

  cd ../demo
  kubectl apply -n argocd -f  argocd-demo.yaml

}




### Main ###

deployTerragrunt
deployArgocd

