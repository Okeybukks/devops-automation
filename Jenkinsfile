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
            }
        }
        stage("Login to Dockerhub"){
            steps{
                sh "echo $DOCKERHUB_CREDENTIAL_PSW | docker login -u $DOCKERHUB_CREDENTIAL_USR --password-stdin"
            }
        }
        stage("Build Application Image"){
            steps{
                echo "This is the test stage for building and pushing Image"
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