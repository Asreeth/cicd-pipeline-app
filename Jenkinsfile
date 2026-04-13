pipeline {
    agent any

    environment {
        // Define these variables
        AWS_REGION = "ap-south-2"
        ECR_REPO = "978861142889.dkr.ecr.ap-south-2.amazonaws.com/ecr-repo"
        IMAGE_NAME = "flask-app"
        APP_SERVER = "10.0.1.47"
    }

    stages {

        stage('Clone') {
            // Pull code from GitHub
            steps {
                echo 'Cloning repository from GitHub...'
                git branch: 'main',
                    url: 'https://github.com/Asreeth/cicd-pipeline-app.git'
            }
        }

        stage('Build') {
            // Build Docker image
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Push to ECR') {
            // Authenticate with ECR
            // Tag the image
            // Push to ECR
            steps {
                sh """
                aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin 978861142889.dkr.ecr.ap-south-2.amazonaws.com
                docker tag ${IMAGE_NAME}:latest ${ECR_REPO}:latest
                docker push ${ECR_REPO}:latest
                """
            }
        }

        stage('Deploy to App Server') {
    steps {
        sshagent(['app-server-ssh']) {
            sh """
                ssh -o StrictHostKeyChecking=no ubuntu@${APP_SERVER} '
                aws ecr get-login-password --region ap-south-2 | docker login --username AWS --password-stdin 978861142889.dkr.ecr.ap-south-2.amazonaws.com
                docker pull ${ECR_REPO}:latest
                docker stop flask-app || true
                docker rm flask-app || true
                docker run -d --name flask-app -p 80:5000 ${ECR_REPO}:latest
                '
            """
        }
    }
}
    }
}