pipeline {
    environment {
        REGISTRY="spider2111/identidock-feature"
        REGISTRY_CREDENTIALS = credentials('dockerhub')
        ANSIBLE_ENV = credentials('097b6767-652c-4d4c-9c77-446888820f59')
        ANSIBLE_DIR="/etc/ansible/"
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
                    sh "whoami"
                }
            }        
            stage("Copying docker compose file") {
                steps {
                    sh ' whoami'
                    sh " cp -f ./docker-compose.yml ${env.ANSIBLE_dir} && chown admin:admin ${env.ANSIBLE_dir}docker-compose.yml "
                    sh " cp -f ./check_ps.sh ${env.ANSIBLE_dir} && chown admin:admin ${env.ANSIBLE_dir}check_ps.sh "
                    sh " cp -f ./rtt.sh ${env.ANSIBLE_dir} && chown admin:admin ${env.ANSIBLE_dir}rtt.sh"
                    sh " cp -f ./load_test.sh ${env.ANSIBLE_dir} && chown admin:admin ${env.ANSIBLE_dir}load_test.sh"
                    sh "cp -f ./docker-compose-stage.yml ${env.ANSIBLE_dir} && chown admin:admin ${env.ANSIBLE_dir}docker-compose-stage.yml"
                }
            }
            stage("Deploy to test server") {
                steps {
                    sh  'cd /etc/ansible && ansible-playbook testing_cd_playbook.yml --extra-vars $ANSIBLE_ENV ' // Если хочу через compose | Рабочее
 //                   sh " rm -f check_ps.sh && rm -f ${env.ANSIBLE_dir}check_ps.sh "
 //                   sh " rm -f rtt.sh && rm -f ${env.ANSIBLE_dir}rtt.sh "
 //                   sh " rm -f load_test.sh && rm -f ${env.ANSIBLE_dir}load_test.sh "
                }
                
            }  

            stage("Deploy ti stage cluster") {
                steps {
                    sh 'cd /etc/ansible && ansible-playbook staging_cd_playbook.yml --extra-vars $ANSIBLE_ENV ' 
                }
            }

        }

    post {
        always {
            sh 'docker logout'
        }
    }
} 
 