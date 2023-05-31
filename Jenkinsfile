pipeline{
    agent any
    triggers {
        githubPush()
    }
    environment{
        DOCKERHUB_CREDENTIAL = credentials("DOCKER_ID")

    }
    stages{
        stage("Run Application Test"){
            steps{

                echo 'Run application test'
                echo 'Testing webhook from vscode'
                echo "$GIT_BRANCH"
            }
        }
        stage("Login to Dockerhub"){
            steps{
                sh "echo $DOCKERHUB_CREDENTIAL_PSW | docker login -u $DOCKERHUB_CREDENTIAL_USR --password-stdin"
            }
        }
        stage("Build and Push Application Image"){
            when {
                expression {
                    return "$GIT_BRANCH == 'main'";
                 }
            }
            steps{
                sh "docker compose up -d"
                // sh "docker build -t achebeh/conduit-app:$BUILD_NUMBER ."
                // sh "docker push achebeh/conduit-app:$BUILD_NUMBER"
                // sh "docker tag achebeh/conduit-app:$BUILD_NUMBER achebeh/conduit-app:latest"
                // sh "docker push achebeh/conduit-app:latest"
            }
        }
        stage("Staging Plan for Infrastructures Job"){
            steps{
                echo "This is the test stage for terraform staging plan"
            }
        }
        stage("Check Financial Expense of Infrastructures Job"){
            steps{
                echo "This is the financial check job"
            }
        }
        stage("Staging Apply for Infrastructures Job"){
            steps{
                echo "This is the terraform staging apply"
            }
        }
        stage("Production Plan for Infrastructures Job"){
            steps{
                echo "This is the test stage for terraform production plan"
            }
        }
        stage("Production Apply for Infrastructures Job"){
            steps{
                echo "This is the terraform production apply"
            }
        }
        stage("Destroy Infrastructures Job"){
            steps{
                echo "This is the terraform destroy job"
            }

        }
    }
}