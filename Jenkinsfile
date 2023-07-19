// Jenkinsfile

pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "your-ecr-registry-url"
        DOCKER_REPO = "your-docker-repo/your-image-name"
        ECR_REGION = "your-ecr-region"
        IMAGE_TAG = ""
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry("${DOCKER_REGISTRY}", "ecr:${ECR_REGION}") {
                        def customTag = sh(returnStdout: true, script: 'echo "v${env.BUILD_NUMBER}"').trim()
                        docker.image("your-dockerfile-path").tag("${DOCKER_REPO}:${customTag}", "${DOCKER_REPO}:${customTag}")
                        docker.image("${DOCKER_REPO}:${customTag}").push()
                        IMAGE_TAG = customTag
                    }
                }
            }
        }
    }

    post {
        always {
            // Update the image tag in the values.yaml after successful build and push
            script {

                sh "version=$(cat ./weather-microservice-helm/values.yaml | grep version: | awk '{print $2}')"
                sh "sed -i 's/$version/${IMAGE_TAG}/' ./weather-microservice-helm/values.yaml"

            }
        }
    }
}
