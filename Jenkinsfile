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
//                    sh "docker push ${env.REGISTRY}:${env.GIT_COMMIT}"
                    sh "docker tag ${env.REGISTRY}:${env.GIT_COMMIT} ${env.REGISTRY}:test"
                    sh "docker push ${env.REGISTRY}:test"
                }
            }        

            stage("Building a testing docker compose") {
                steps {
                sh 'docker compose up -d'
                sh 'docker compose stop && docker compose rm -fv'
              }
            }

            stage("Copying docker compose file") {
                steps {
                    sh 'cp ./docker-compose.yml /etc/ansible/ && chown admin:admin /etc/ansible/docker-compose.yml '
                    sh 'cp -rf ./scripts /etc/ansible/ && chown admin:admin /etc/ansible/scripts/* '
                    sh 'su admin'
                    sh 'cd /etc/ansible &&  ansible-playbook run_docker_compose_playbook.yml --extra-vars "ansible_sudo_pass=stk12345"'
                }
            }
            stage("Deploy to stage server") {
                steps {
                    sh 'cd /etc/ansible &&  ./scripts/check_ps.sh'
                }
            }  

        }

    post {
        always {
            sh 'docker logout'
        }
    }
} 
 