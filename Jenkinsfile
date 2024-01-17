pipeline {
    agent {
        label '167-vm'
    }
        stages {
            stage ("Docker image build") {
                
                steps {
                    scripts {
                        def commitSha = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()
                        sh "whoami"
                        sh "docker build -t pipeline:${commitSha} ."

                    }

                }
            }
        }
}