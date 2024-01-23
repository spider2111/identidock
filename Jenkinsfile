pipeline {
    environment {
        REGISTRY="spider2111/identidock-feature"
        REGISTRY_CREDENTIALS = credentials('dockerhub')
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
                }
            }        
            stage("Copying docker compose file") {
                steps {
                    sh 'su admin'
                    sh " cp -f ./docker-compose.yml ${env.ANSIBLE_dir} && chown admin:admin ${env.ANSIBLE_dir}docker-compose.yml "
                    sh " cp -f ./check_ps.sh ${env.ANSIBLE_dir} && chown admin:admin ${env.ANSIBLE_dir}check_ps.sh "
                    sh " cp -f ./rtt.sh ${env.ANSIBLE_dir} && chown admin:admin ${env.ANSIBLE_dir}rtt.sh"
                    sh " cp -f ./load_test.sh ${env.ANSIBLE_dir} && chown admin:admin ${env.ANSIBLE_dir}load_test.sh"
                }
            }
            stage("Deploy to test server") {
                steps {
                    sh  'cd /etc/ansible && ansible-playbook testing_cd_playbook.yml --extra-vars "ansible_sudo_pass=stk12345"' // Если хочу через compose | Рабочее
                    sh " rm -f check_ps.sh && ${env.ANSIBLE_dir}check_ps.sh "
                    sh " rm -f rtt.sh && ${env.ANSIBLE_dir}rtt.sh "
                    sh " rm -f load_test.sh && ${env.ANSIBLE_dir}load_test.sh "
                }
                
            }  

        }

    post {
        always {
            sh 'docker logout'
        }
    }
} 
 