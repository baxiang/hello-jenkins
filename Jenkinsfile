pipeline {
    agent any
    environment {
        registry = "baxiang/hello-jenkins"
    }
    stages {
        stage('Git') {
              steps {
                git 'https://github.com/baxiang/hello-jenkins'
              }
            }
        stage('Build') {
            steps {
                sh "docker build -t ${registry}:$BUILD_NUMBER ."
            }
        }
        stage('Testing Image'){
              steps{
                sh "docker run --rm ${registry}:$BUILD_NUMBER"
              }
        }
        stage('Push') {
            withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                        sh "docker login -u ${dockerHubUser} -p ${dockerHubPassword}"
                        sh "docker push ${registry}:$BUILD_NUMBER"
                    }
        }
        stage('Remove Unused docker image') {
              steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
              }
        }
    }
}