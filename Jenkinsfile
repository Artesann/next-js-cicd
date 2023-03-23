pipeline {
  agent any
  environment {
    PG_ROUTING_KEY = credentials('pagerduty-integration-key')
  }
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
        sh "helm upgrade best-app --install --set image.tag=${params.image_tag} kubernetes/best-app"
      } 
    } 
  }
  post {
    failure {
      script {
          def pagerdutyUrl = 'https://events.pagerduty.com/v2/enqueue'
          def routing_key = "${PG_ROUTING_KEY}"
          def payload = [
              'routing_key': routing_key,
              'event_action': 'trigger',
              'payload': [
                  summary: "Pipeline failed in ${env.STAGE_NAME}",
                  source: "Jenkins",
                  severity: "critical",
                  custom_details: "Pipeline ${env.JOB_NAME} failed in stage ${env.STAGE_NAME}"
              ]
          ]
          def response = httpRequest httpMode: 'POST', url: pagerdutyUrl, contentType: 'APPLICATION_JSON', requestBody: groovy.json.JsonOutput.toJson(payload)
          echo "PagerDuty Response: ${response.content}"
      }
    }
  }
}


