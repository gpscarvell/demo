# Geoffrey Scarvell's Weather Demo
### _Expanation of this repo_

By running the terragrunt apply_all this repo deploys an AWS VPC, Route53 hosted Zone, AWS VPN, RDS, EKS, EKS node group, Argocd as a controller running in EKS, a weather application and registers the weather application to Route53 private hosted zone using external DNS.  
  
All subsequent updates to the application will trigger a Github action which will build the Docker image, push the image to ECR, update the helm values file with the commit image tag which will trigger Argocd to deploy the helm chart.  
  
This is a small demo to allow you to understand I have the knowledge skills and abilities to build dynamic cloud elastic ephemeral environments, there is much more that I would add in real time environments.

> Deploy infrastructure 
* use terraform/terragrunt
* terragrunt keeps terraform state DRY and dynamicaly resolves dependencies allowing for the creation of ephemeral environments when used with Github actions or Gitlab-CI

> CI
* Github actions located in .gihhub/workflows directory

> CD Argocd
* Argocd deploys the helm chart when the image tag in the values files is updated by the CI
* Other Devops applications that would be deployed are:  

** Kubernetes external DNS  
** Kubernetes externall secrets  
**  Cluster auto-scaler  
**  aws-ebs-csi-driver  
**  nginx-ingress-controller  
** Kubernetes certmanager


