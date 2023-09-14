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

     

- Import a HTML file and watch it magically convert to Markdown
- Drag and drop images (requires your Dropbox account be linked)
- Import and save files from GitHub, Dropbox, Google Drive and One Drive
- Drag and drop markdown and HTML files into Dillinger
- Export documents as Markdown, HTML and PDF

Markdown is a lightweight markup language based on the formatting conventions
that people naturally use in email.
As [John Gruber] writes on the [Markdown site][df1]



> The overriding design goal for Markdown's
> formatting syntax is to make it as readable
> as possible. The idea is that a
> Markdown-formatted document should be
> publishable as-is, as plain text, without
> looking like it's been marked up with tags
> or formatting instructions.

This text you see here is *actually- written in Markdown! To get a feel
for Markdown's syntax, type some text into the left window and
watch the results in the right.

## Tech

Dillinger uses a number of open source projects to work properly:

- [AngularJS] - HTML enhanced for web apps!
- [Ace Editor] - awesome web-based text editor
- [markdown-it] - Markdown parser done right. Fast and easy to extend.
- [Twitter Bootstrap] - great UI boilerplate for modern web apps
- [node.js] - evented I/O for the backend
- [Express] - fast node.js network app framework [@tjholowaychuk]
- [Gulp] - the streaming build system
- [Breakdance](https://breakdance.github.io/breakdance/) - HTML
to Markdown converter
- [jQuery] - duh

And of course Dillinger itself is open source with a [public repository][dill]
 on GitHub.

## Installation

Dillinger requires [Node.js](https://nodejs.org/) v10+ to run.

Install the dependencies and devDependencies and start the server.

```sh
cd dillinger
npm i
node app
```

For production environments...

```sh
npm install --production
NODE_ENV=production node app
```

## Plugins

Dillinger is currently extended with the following plugins.
Instructions on how to use them in your own application are linked below.

| Plugin | README |
| ------ | ------ |
| Dropbox | [plugins/dropbox/README.md][PlDb] |
| GitHub | [plugins/github/README.md][PlGh] |
| Google Drive | [plugins/googledrive/README.md][PlGd] |
| OneDrive | [plugins/onedrive/README.md][PlOd] |
| Medium | [plugins/medium/README.md][PlMe] |
| Google Analytics | [plugins/googleanalytics/README.md][PlGa] |

## Development

Want to contribute? Great!

Dillinger uses Gulp + Webpack for fast developing.
Make a change in your file and instantaneously see your updates!

Open your favorite Terminal and run these commands.

First Tab:

```sh
node app
```

Second Tab:

```sh
gulp watch
```

(optional) Third:

```sh
karma test
```

#### Building for source

For production release:

```sh
gulp build --prod
```

Generating pre-built zip archives for distribution:

```sh
gulp build dist --prod
```

## Docker

Dillinger is very easy to install and deploy in a Docker container.

By default, the Docker will expose port 8080, so change this within the
Dockerfile if necessary. When ready, simply use the Dockerfile to
build the image.

```sh
cd dillinger
docker build -t <youruser>/dillinger:${package.json.version} .
```

This will create the dillinger image and pull in the necessary dependencies.
Be sure to swap out `${package.json.version}` with the actual
version of Dillinger.

Once done, run the Docker image and map the port to whatever you wish on
your host. In this example, we simply map port 8000 of the host to
port 8080 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -p 8000:8080 --restart=always --cap-add=SYS_ADMIN --name=dillinger <youruser>/dillinger:${package.json.version}
```

> Note: `--capt-add=SYS-ADMIN` is required for PDF rendering.

Verify the deployment by navigating to your server address in
your preferred browser.

```sh
127.0.0.1:8000
```

## License

MIT

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>
