pipeline{
    agent any
    stages{
        stage("Run Application Test"){
            steps{
                echo 'Run application test'
                echo 'Testing webhoo'
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