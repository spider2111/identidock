pipeline {
    agent {
        label '167-vm'
    }
        stages {
            stage("Docker image build") {      
                steps {
                        sh "whoami"
                        sh "docker build -t pipeline:${env.BUILD_TAG} ."
                }
            }
        }
}