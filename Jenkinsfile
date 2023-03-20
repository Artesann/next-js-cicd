pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'cd best-app'
        sh 'npm install'
        sh 'npm run build'
      }
    }
    stage('Test') {
      steps {
        sh 'npm run test'
      }
    }
    stage('Publish') {
      steps {
        sh 'npm run publish'
      }
    }
    stage('Deploy') {
      steps {
        sh 'npm run deploy'
      }
    }
  }
}
