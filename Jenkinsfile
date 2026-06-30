pipeline {
    agent any

    environment {
        DEV_IMAGE  = "jude795/dev:v1"
        PROD_IMAGE = "jude795/prod:v1"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Image') {
            steps {
                 script {
                     if (env.GIT_BRANCH?.contains("master")) {
                         env.IMAGE_NAME = env.PROD_IMAGE
                     } else {
                         env.IMAGE_NAME = env.DEV_IMAGE
                     }

                     echo "Building image: ${env.IMAGE_NAME}"
        }
    }
}        
    stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: '92e3d338-3f5e-4ffd-b16c-b7991039e07e',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker stop devops-app || true
                docker rm devops-app || true
                docker run -d --name devops-app -p 80:80 $IMAGE_NAME
                '''
            }
        }
    }
}
