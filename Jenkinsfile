pipeline {
    agent any

    environment {
        GIT_PROJECT_ADDR="https://github.com/baxiang/hello-jenkins"
        IMAGE_NAME="hello-jenkins"
        IMAGE_REGISTRY="baxiang/${IMAGE_NAME}"
        VERSION_ID="${BUILD_ID}"
        }
    stages {
        stage('Git') {
              steps {
                git $GIT_PROJECT_ADDR
              }
            }
        stage('Build') {
            steps {
                sh "docker build -t ${IMAGE_REGISTRY}:${VERSION_ID} ."
            }
        }
        stage('Testing Image'){
              steps{
                sh "docker run --rm ${IMAGE_REGISTRY}:${VERSION_ID}"
              }
        }
        stage('Push') {
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                                            // Push image and tag it with our build number for versioning purposes.
                                            app.push("${env.BUILD_NUMBER}")
                                            // Push the same image and tag it as the latest version (appears at the top of our version list).
                                            app.push("latest")
                                        }
        }
        stage('Remove Unused docker image') {
              steps{
                sh "docker rmi ${IMAGE_REGISTRY}:${VERSION_ID}"
              }
        }
    }
}