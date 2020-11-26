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
        stage('Push image') {
                /* Finally, we'll push the image with two tags:
                 * First, the incremental build number from Jenkins
                 * Second, the 'latest' tag.
                 * Pushing multiple tags is cheap, as all the layers are reused. */
                docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                    app.push("${env.BUILD_NUMBER}")
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