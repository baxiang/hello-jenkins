pipeline {
    agent any

    environment {
        //GIT_PROJECT_ADDR="https://github.com/baxiang/hello-jenkins"
        IMAGE_NAME="hello-jenkins"
        IMAGE_REGISTRY="baxiang/${IMAGE_NAME}"
        VERSION_ID="${BUILD_ID}"
        dockerImage = ""
        }
    stages {
        stage('Git') {
              steps {
                git "https://github.com/baxiang/hello-jenkins"
              }
            }
        stage('Build') {
            steps {

            }
        }
        stage('Push image') {

            steps{
               script {
                  docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                           docker.build("$IMAGE_REGISTRY",  '.')
                          docker.image("$IMAGE_REGISTRY").push 'latest'
                          docker.image("$IMAGE_REGISTRY").push()
                     }

                     }

               }

                /* Finally, we'll push the image with two tags:
                 * First, the incremental build number from Jenkins
                 * Second, the 'latest' tag.
                 * Pushing multiple tags is cheap, as all the layers are reused. */

        }
        stage('Remove Unused docker image') {
              steps{
                sh "docker rmi ${IMAGE_REGISTRY}:${VERSION_ID}"
              }
        }
    }
}