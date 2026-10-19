pipeline {
    agent any

    environment {
        STUDENT_NAME    = 'Abylai'
        STUDENT_SURNAME = 'Asan'
        STUDENT_GROUP   = 'IT2-2301'
        STUDENT_ID      = '37804'
        IMAGE_NAME      = 'asan-abylai-devops'
        CONTAINER_NAME  = 'asan-abylai-container'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh '''
                    echo "Student: $STUDENT_NAME $STUDENT_SURNAME"
                    echo "Group: $STUDENT_GROUP"
                    echo "Student ID: $STUDENT_ID"
                    echo "Git commit: $(git rev-parse HEAD)"
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    chmod +x scripts/Asan_Abylai_system.sh
                    ./scripts/Asan_Abylai_system.sh
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    set -e
                    bash -n scripts/Asan_Abylai_system.sh
                    test -f Asan_Abylai_info.txt
                    test -f Dockerfile
                    test -f app/app.py
                    test -f docker-compose.yml
                    echo "All checks passed"
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    docker rm -f $CONTAINER_NAME || true
                    docker run -d --name $CONTAINER_NAME \
                        -e STUDENT_NAME=$STUDENT_NAME \
                        -e STUDENT_SURNAME=$STUDENT_SURNAME \
                        -e STUDENT_GROUP=$STUDENT_GROUP \
                        -e STUDENT_ID=$STUDENT_ID \
                        $IMAGE_NAME
                    sleep 3
                    docker ps --filter name=$CONTAINER_NAME
                    docker logs $CONTAINER_NAME
                '''
            }
        }
    }

    post {
        success { echo 'Pipeline finished successfully' }
        failure { echo 'Pipeline failed - check the stage that is marked red' }
    }
}
