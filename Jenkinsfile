pipeline {
    environment {
        REGISTRY="spider2111/identidock-feature"
        REGISTRY_CREDENTIALS = credentials('dockerhub')
    }
        agent {
            label '167-vm'
        }
        stages {
            stage("Docker image build") {      
                steps {
                        sh "whoami"
                        sh "docker build -t ${env.REGISTRY}:${BUILD_TIMESTAMP}. ."
                    }
                }
            stage("Login to dockerhub") {
                steps {
                    sh('echo $REGISTRY_CREDENTIALS_PSW | docker login -u $REGISTRY_CREDENTIALS_USR --password-stdin')
                }

            }

            stage("Push image") {
                steps {
                    sh "docker push ${env.REGISTRY}:${BUILD_TIMESTAMP}."
                    sh "docker tag ${env.REGISTRY}:${BUILD_TIMESTAMP}. ${env.REGISTRY}:test"
                    sh "docker push ${env.REGISTRY}:test"
                }
            }        

            stage("Deploy a testing docker compose") {
              steps {
                sh 'docker compose up -d'
                sh 'docker compose stop && docker compose rm'
              }
            }

        }

    post {
        always {
            sh 'docker logout'
        }
    }
} 
 