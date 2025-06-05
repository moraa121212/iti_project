pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'amrhatem'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/moraa121212/iti_project.git'
            }
        }
        stage('Build Backend Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_REGISTRY}/backend-flask-app:${IMAGE_TAG} ./Backend'
                sh 'docker tag ${DOCKER_REGISTRY}/backend-flask-app:${IMAGE_TAG} ${DOCKER_REGISTRY}/backend-flask-app:latest'
            }
        }
        stage('Build Frontend Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_REGISTRY}/frontend-app:${IMAGE_TAG} ./Frontend'
                sh 'docker tag ${DOCKER_REGISTRY}/frontend-app:${IMAGE_TAG} ${DOCKER_REGISTRY}/frontend-app:latest'
            }
        }
        stage('Scan Docker Images with Trivy') {
            steps {
                sh 'trivy image --exit-code 0 --severity HIGH,CRITICAL ${DOCKER_REGISTRY}/backend-flask-app:${IMAGE_TAG}'
                sh 'trivy image --exit-code 0 --severity HIGH,CRITICAL ${DOCKER_REGISTRY}/frontend-app:${IMAGE_TAG}'
            }
        }
        stage('Push Docker Images') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    sh 'docker push ${DOCKER_REGISTRY}/backend-flask-app:${IMAGE_TAG}'
                    sh 'docker push ${DOCKER_REGISTRY}/backend-flask-app:latest'
                    sh 'docker push ${DOCKER_REGISTRY}/frontend-app:${IMAGE_TAG}'
                    sh 'docker push ${DOCKER_REGISTRY}/frontend-app:latest'
                }
            }
        }
        stage('Update K8s Manifests with Image Tags') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-creds', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                    sh '''
                        git config user.email "amr.hatem2h@gmail.com"
                        git config user.name "moraa121212"
                        sed -i "s|image: backend-flask-app:.*|image: ${DOCKER_REGISTRY}/backend-flask-app:${IMAGE_TAG}|g" kubernetes/backend-deployment.yaml
                        sed -i "s|image: frontend-app:.*|image: ${DOCKER_REGISTRY}/frontend-app:${IMAGE_TAG}|g" kubernetes/frontend-deployment.yaml
                        git add kubernetes/backend-deployment.yaml kubernetes/frontend-deployment.yaml
                        git commit -m "Update K8s manifests with new image tags for build ${IMAGE_TAG}" || echo "No changes to commit"
                        git push https://${GIT_USER}:${GIT_PASS}@github.com/moraa121212/iti_project.git HEAD:main
                    '''
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
        failure {
            echo 'Pipeline failed. Check the logs for details.'
        }
    }
}
