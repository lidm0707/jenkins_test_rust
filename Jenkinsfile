pipeline {
    agent any
    stages {
        stage('Setup') {
            steps {
                echo 'Setting up Rust environment...'
                sh '''
                if ! command -v rustup &> /dev/null
                then
                    echo "rustup not found, installing..."
                    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
                    export PATH="$HOME/.cargo/bin:$PATH"
                else
                    echo "rustup is already installed"
                fi
                rustup show
                '''
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running unit tests...'
                sh 'cargo test'
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
