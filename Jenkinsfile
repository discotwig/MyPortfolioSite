pipeline {
    agent any

    environment {
        IMAGE_NAME = 'portfolio-site'
        CONTAINER_NAME = 'portfolio-container'
        NETWORK_NAME = 'allen_app-network' // Use centralized proxy's network
    }

    stages {
        stage('Build') {
            steps {
                // Build the Docker image
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Deploy') {
            steps {
                // Stop and remove the existing container, if it exists
                sh """
                    docker stop ${CONTAINER_NAME} || true && \
                    docker rm ${CONTAINER_NAME} || true
                """

                // Run the new container without exposing ports
                sh "docker run -d --name ${CONTAINER_NAME} ${IMAGE_NAME}"

                // Connect the container to the centralized Nginx proxy's network
                sh "docker network connect ${NETWORK_NAME} ${CONTAINER_NAME}"
            }
        }
    }
}
