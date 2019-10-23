pipeline {
   agent {
    label 'docker' 
  }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('build') {
            steps {
             bat "docker -v"
            }
        }
    }
}