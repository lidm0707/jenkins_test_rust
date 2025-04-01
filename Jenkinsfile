pipeline {
    agent {
        docker {
            image 'my-rust-ci:latest'  // ใช้ Docker image ที่เราสร้างจาก Dockerfile
            args '-v /var/run/docker.sock:/var/run/docker.sock' // ใช้ Docker daemon
        }
    }

    stages {
        stage('Setup') {
            steps {
                sh 'sudo cargo --version' // ใช้ sudo เรียก cargo
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running unit tests...'
                sh 'sudo cargo test'
            }
        }

        stage('Build Docker Image') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo 'Building Docker image...'
                sh '''
                sudo docker build -t test-ci-rust:latest .
                '''
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
        }
        success {
            echo 'Build and deployment succeeded!'
        }
        failure {
            echo 'Build or tests failed. Deployment skipped.'
        }
    }
}
