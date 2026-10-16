pipeline {
    agent any

    triggers {
        pollSCM('H/5 * * * *')
    }

    environment {
        IMAGE_NAME = 'demo-jenkins'
        CONTAINER_NAME = 'demo-jenkins'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build App with Maven') {
            steps {
                sh 'mvn -B clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .'
            }
        }

        stage('Deploy Docker Container') {
            steps {
                sh '''
                    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true

                    docker run -d \
                      --name ${CONTAINER_NAME} \
                      -p 2222:2222 \
                      ${IMAGE_NAME}:${BUILD_NUMBER}
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    echo "===== CONTAINER STATUS ====="
                    docker ps --filter "name=${CONTAINER_NAME}"

                    echo "===== APPLICATION CHECK ====="
                    for i in $(seq 1 30); do
                        if curl -fsS http://127.0.0.1:2222/ -o /dev/null; then
                            echo "Application HTTP check: SUCCESS"
                            exit 0
                        fi
                        sleep 2
                    done

                    echo "Application did not respond on port 2222"
                    docker logs ${CONTAINER_NAME}
                    exit 1
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline CI/CD completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check the stage logs.'
        }
    }
}
