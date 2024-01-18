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
                        sh "docker build -t ${env.REGISTRY}:${env.GIT_COMMIT} ."
                    }
                }
            stage("Login to dockerhub") {
                steps {
                    sh('echo $REGISTRY_CREDENTIALS_PSW | docker login -u $REGISTRY_CREDENTIALS_USR --password-stdin')
                }

            }

            stage("Push image") {
                steps {
                    sh "docker push ${env.REGISTRY}:${env.GIT_COMMIT}"
                }
            }        

            stage("Deploy docker compose") {
              steps {
                sh 'docker compose up -d'
              }
            }

        }

    post {
        always {
            sh 'docker logout'
        }
    }
} 
 