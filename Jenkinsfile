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
             sh "docker build -t scheduler-service:B${BUILD_NUMBER} -f Dockerfile ."
            }
        }
    }
}