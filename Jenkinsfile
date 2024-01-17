pipeline {
    agent {
        label '167-vm'
    }
        stages {
            stage ("Docker image build") {
                steps {
                    sh "whoami"
                    sh "echo 123"
                    sh "docker build -t pipeline:image ."
                }
            }
        }
}
