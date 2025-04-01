pipeline {
    agent {
        docker {
            image 'rust:latest' 
        }
    }

    stages {
        stage('Setup') {
            steps {
                sh 'cargo --version'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running unit tests...'
                sh 'cargo test'
            }
        }

        stage('Install Docker CLI') {
            steps {
                echo 'Installing Docker CLI...'
                sh 'apt-get update && apt-get install -y docker.io'
            }
        }

        stage('Build Docker Image') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo 'Building Docker image...'
                sh '''
                docker build -t test-ci-rust:latest .
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
