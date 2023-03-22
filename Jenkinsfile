pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        withDockerContainer("node:19.8") {
            sh 'npm install'
            sh 'npm run build'
        }
      }
    }
    stage('Test') {
      steps {
        withDockerContainer("node:19.8") {
            sh 'sleep 3'
        }
      }
    }
    stage('Publish') {
      steps {
        sh "docker build -t gcr.io/prismatic-crow-350413/best-app:${params.image_tag} ."
        sh "docker push gcr.io/prismatic-crow-350413/best-app:${params.image_tag}"
      }
    }
    stage('Deploy') {
      steps {
        sh "helm upgrade best-app best-app --install --set image.tag=${params.image_tag} kubernetes/best-app"
      } 
    } 
  }
}

