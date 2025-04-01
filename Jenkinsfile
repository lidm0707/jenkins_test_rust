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
                else
                    echo "rustup is already installed"
                fi
                
                # Source cargo environment for POSIX shells using dot (.)
                . $HOME/.cargo/env  # Using dot (.) instead of source
                
                # Verify that cargo is available
                if ! command -v cargo &> /dev/null
                then
                    echo "cargo could not be found, something went wrong with the installation"
                    exit 1
                fi
                cargo --version
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
