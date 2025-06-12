pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'amrhatem'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        SONAR_PROJECT_KEY = 'iTi'
        SONAR_PROJECT_NAME = 'iti-project'
        SONAR_SCANNER_HOME = tool 'project-sonnar'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/moraa121212/iti_project.git'
            }
        }
        stage('Run Backend Static Analysis (SonarQube)') {
            steps {
                dir('backend') {
                    withSonarQubeEnv('project') {
                        sh "${SONAR_SCANNER_HOME}/bin/sonar-scanner " +
                           "-Dsonar.projectKey=${SONAR_PROJECT_KEY}_Backend " +
                           "-Dsonar.projectName='${SONAR_PROJECT_NAME} Backend' " +
                           "-Dsonar.sources=." +
                           "-Dsonar.python.version=3"
                    }
                }
            }
        }
        stage('Run Frontend Static Analysis (SonarQube)') {
            steps {
                dir('frontend') {
                    withSonarQubeEnv('project') {
                        sh "${SONAR_SCANNER_HOME}/bin/sonar-scanner " +
                           "-Dsonar.projectKey=${SONAR_PROJECT_KEY}_Frontend " +
                           "-Dsonar.projectName='${SONAR_PROJECT_NAME} Frontend' " +
                           "-Dsonar.sources=."
                    }
                }
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
                        sed -i "s|image: amrhatem/backend-flask-app:.*|image: ${DOCKER_REGISTRY}/backend-flask-app:${IMAGE_TAG}|g" kubernetes/backend-deployment.yaml
                        sed -i "s|image: amrhatem/frontend-app:.*|image: ${DOCKER_REGISTRY}/frontend-app:${IMAGE_TAG}|g" kubernetes/frontend-deployment.yaml
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
