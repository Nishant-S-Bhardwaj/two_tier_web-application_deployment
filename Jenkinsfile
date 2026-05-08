pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // This pulls your latest code from GitHub
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building the Docker Images...'
                sh 'docker compose build'
            }
        }

        stage('Deploy App') {
            steps {
                echo 'Starting the Two-Tier Application...'
                // -d keeps it running after Jenkins finishes the job
                sh 'docker compose up -d'
            }
        }

        stage('Verify') {
            steps {
                echo 'Verification...'
                sh 'docker ps'
            }
        }
    }
}