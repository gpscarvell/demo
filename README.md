# Benefits of Cloud Automation Using Gitops
### _Trade fixed expense for variable expense_

>Instead of having to invest heavily in servers before you know how you’re going to use them, you can pay only when you consume computing resources, and pay only for how much you consume.

### _Stop guessing capacity_

>Eliminate guessing on your infrastructure capacity needs. When you make a capacity decision prior to deploying an application, you often end up either sitting on expensive idle resources or dealing with limited capacity. With cloud computing, these problems go away. You can access as much or as little capacity as you need, and scale up and down as required with only a few minutes’ notice.

### _Increase speed and agility_

>In a cloud computing environment, new IT resources are only a click away, which means that you reduce the time to make those resources available to your developers from weeks to just minutes. This results in a dramatic increase in agility for the organization, since the cost and time it takes to experiment and develop is significantly lower.

### _Go global in minutes_ 

>Easily deploy your application in multiple regions around the world with just a few clicks. This means you can provide lower latency and a better experience for your customers at minimal cost.



# Automating the Cloud with Gitops
### Principle #1: GitOps Is Declarative
>A system managed by GitOps must have a desired state expressed declaratively.

### Principle #2: GitOps Apps Are Versioned and Immutable
>The desired state is stored in a way that enforces immutability, versioning, and complete version history.
>rollbacks should be simple.

### Principle #3: GitOps Apps Are Pulled Automatically
>Software automation automatically pulls the declared state declaration from the source.

>Argocd is a set of continuous and progressive delivery solutions for Kubernetes that are open and extensible, enabling GitOps and progressive delivery for developers and infrastructure teams.

### Principal #4: GitOps Apps Are Continuously Reconciled
>Kubernetes controllers continually observe the actual system state and attempt to apply the desired state.

# Common GitOps tools
- [Atlantis - terraform](https://medium.com/nerd-for-tech/terraforming-the-gitops-way-9417cf4abf58)
- [Argocd](https://argo-cd.readthedocs.io/en/stable/)
- [terragrunt - gitlabci](https://medium.com/nerd-for-tech/gitops-terraform-project-setup-using-terragrunt-and-gitlab-pipelines-b6b0be4b9b32)
- [Keptn](https://lifecycle.keptn.sh/)
- [Many more technologies in CNCF](https://landscape.cncf.io/)

# Putting the pieces together
### _terraform/terragrunt providers_
- [SAP Commerce Cloud Deployment](https://registry.terraform.io/providers/foryouandyourcustomers/sapcc/latest/docs/resources/deployment)
- [SAP Business Technology Platform](https://registry.terraform.io/providers/SAP/btp/latest/docs)
- [AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- Many more to include all clouds and many technology stacks

### _Dockerfile_ (.Net example)
```sh
# Use the official .NET Core SDK as the base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files to the container
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Create a runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the published application from the build image to the runtime image
COPY --from=build /app/out ./

# Expose the port the application will listen on
EXPOSE 80

# Start the application when the container starts
ENTRYPOINT ["dotnet", "YourAppName.dll"]
```
### _gitlab-ci_

```sh
stages:
  - build
  - deploy

variables:
  DOCKER_IMAGE_NAME: your-docker-image-name
  ECR_REGISTRY: your-ecr-registry-url
  AWS_DEFAULT_REGION: your-aws-region
  HELM_CHART_PATH: ./path/to/helm/chart
  HELM_RELEASE_NAME: your-helm-release-name

before_script:
  - echo "Logging in to AWS ECR"
  - aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY

build:
  stage: build
  script:
    - echo "Building Docker image"
    - docker build -t $DOCKER_IMAGE_NAME .
    - echo "Tagging Docker image with ECR repository URL"
    - docker tag $DOCKER_IMAGE_NAME $ECR_REGISTRY/$DOCKER_IMAGE_NAME:$CI_COMMIT_SHA
    - echo "Pushing Docker image to ECR"
    - docker push $ECR_REGISTRY/$DOCKER_IMAGE_NAME:$CI_COMMIT_SHA

deploy:
  stage: deploy
  script:
    - echo "Checking out Helm chart"
    - git clone $CI_REPOSITORY_URL $HELM_CHART_PATH
    - cd $HELM_CHART_PATH
    - echo "Updating values.yaml with new Docker image tag"
    - sed -i "s|image: $DOCKER_IMAGE_NAME:.*|image: $ECR_REGISTRY/$DOCKER_IMAGE_NAME:$CI_COMMIT_SHA|" values.yaml
    - echo "Committing and pushing updated values.yaml"
    - git config user.name "Your GitLab CI/CD Bot"
    - git config user.email "bot@example.com"
    - git add values.yaml
    - git commit -m "Update Docker image tag in values.yaml"
    - git push origin $CI_COMMIT_REF_NAME
```

### _argocd_

```sh
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-helm-app
  namespace: argocd
spec:
  destination:
    name: in-cluster
    namespace: default  # Namespace where you want to deploy the Helm chart
  source:
    repoURL: https://github.com/your-organization/your-helm-repo.git  # URL of your Helm chart repository
    targetRevision: HEAD  # The revision of the Helm chart you want to deploy
    path: path/to/helm/chart  # Path to the Helm chart within the repository
    helm:
      valueFiles:
        - values.yaml  # Path to your custom values.yaml file (optional)
  project: default  # ArgoCD project to which this application belongs (create one if not exists)
  syncPolicy:
    automated:
      prune: true  # Automatically delete resources not declared in Helm chart
      selfHeal: true  # Automatically reapply manifests if they drift from desired state
  # Optional: Health checks for your application
  health:
    status: {}
    postSync: {}
```

# Aditional Cloud Automation Benefits      

- Rapidly deploy emphemeral environments from git feature branches
- Eliminate need to performance test static environment
- Eliminate expenvice agent based monitoring tools and replace with open source time series monitoring tools
- All configuration maintained in declarative configuration and versioned in git creates a consistant approach to change
- Change process can be automated with orchastration tools
- Continuous deployment
- Working off a unified platform 
