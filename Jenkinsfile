pipeline {
    agent any

    environment {
        IMAGE_NAME = "jude795/dev:v1"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'sudo docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | sudo docker login -u "$DOCKER_USER" --password-stdin
                    sudo docker push $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                sudo docker stop devops-app || true
                sudo docker rm devops-app || true
                sudo docker run -d --name devops-app -p 80:80 $IMAGE_NAME
                '''
            }
        }
    }
}
