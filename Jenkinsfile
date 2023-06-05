def djangoSecretKey = credentials("DJANGO_SECRET_KEY")
def dbName = "postgres"
def dbUser = "postgres"
def dbPassword = credentials("DB_PASSWORD")
def dbPort = 5432
def allowedHosts = credentials("ALLOWED_HOSTS")

def envFilePath = "temp_env.list"
def envFileContent = """
    DJANGO_SECRET_KEY=$djangoSecretKey\n
    DB_NAME=$dbName\n
    DB_USER=$dbUser\n
    DB_PASSWORD=$dbPassword\n
    DB_PORT=$dbPort\n
    POSTGRES_DB=$dbName\n
    POSTGRES_USER=$dbUser\n
    POSTGRES_PASSWORD=$dbPassword\n
    ALLOWED_HOSTS=$allowedHosts
"""
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
            }
        }
        stage("Login to Dockerhub"){
            steps{
                sh 'echo $DOCKERHUB_CREDENTIAL_PSW | docker login -u $DOCKERHUB_CREDENTIAL_USR --password-stdin'
            }
        }
        stage("Build and Push Application Image"){
            when {
                expression {

                    return "$GIT_BRANCH == main"; 
                 }
            }
            steps{
                script {
                    writeFile file: envFilePath, text: envFileContent
                    archiveArtifacts artifacts: 'temp_env.list'

                    // echo "Environment file content:\n${envFileContent}"


                    // sh "docker compose --env-file temp_env.list up"

                    // sh "rm ${envFilePath}"

                }
                // sh 'docker compose up -d'
            }
            // post {
            //     always {
            //         archiveArtifacts artifacts: 'temp_env.list'
            //     }
            // }
        }
        // stage("Initializing Terraform"){
        //     steps{
        //         dir('./terraform'){
        //             withCredentials([[
        //                 $class: 'AmazonWebServicesCredentialsBinding',
        //                 credentialsId: "AWS_ID",
        //                 accessKeyVariable: "AWS_ACCESS_KEY_ID",
        //                 secretKeyVariable: "AWS_SECRET_ACCESS_KEY"
        //             ]]){
        //                 sh 'terraform init'
        //             } 
        //         }    
        //     }
        // }
        stage("Staging Plan for Infrastructures Job"){
            steps{
                dir("./terraform"){
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: "AWS_ID",
                        accessKeyVariable: "AWS_ACCESS_KEY_ID",
                        secretKeyVariable: "AWS_SECRET_ACCESS_KEY"
                    ]]){
                        // sh 'terraform plan -out tfplan.binary'
                        // sh 'terraform show -json tfplan.binary > plan.json'

                        
                        sh 'echo "Hello world" > plan.json'
                        step([$class: 'CopyArtifact', projectName: 'Build and Push Application Image', filter: 'temp_env.list'])

                        
                        sh 'cat temp_env.list'
                        
                    } 
                }
            }
            // post {
            //     always {
            //         archiveArtifacts artifacts: '**/terraform/plan.json'
            //     }
            // }
        }
        // stage("Check Financial Expense of Infrastructures Job with Infracost"){
        //     // agent {
        //     //     docker {
        //     //         image 'infracost/infracost:ci-latest'
        //     //         args "--user=root --entrypoint=''"
        //     //     }
        //     // }
        //     // environment {
        //     //    INFRACOST_API_KEY = credentials("INFRACOST_API_KEY")
        //     //    INFRACOST_VCS_PROVIDER = 'github'
        //     //    INFRACOST_VCS_REPOSITORY_URL = 'https://github.com/Okeybukks/devops-automation'
        //     //    INFRACOST_VCS_BASE_BRANCH = 'main'
        //     // }
        //     steps{
        //         // echo "This is the financial check job"
        //         // sh 'infracost breakdown --path plan.json'
        //         // sh 'infracost breakdown --path . --format=json --out-file=/tmp/infracost-base.json'
        //         // sh 'cat /tmp/infracost-base.json'
        //         // sh 'infracost diff --path . --format=json --compare-to=/tmp/infracost-base.json --out-file=/tmp/infracost.json'                                                                       
        //     }
        // }
        // stage("Staging Apply for Infrastructures Job"){
        //     steps{
        //         echo "This is the terraform staging apply"
        //     }
        // }
        // stage("Production Plan for Infrastructures Job"){
        //     steps{
        //         echo "This is the test stage for terraform production plan"
        //     }
        // }
        // stage("Production Apply for Infrastructures Job"){
        //     steps{
        //         echo "This is the terraform production apply"
        //     }
        // }
        // stage("Destroy Infrastructures Job"){
        //     steps{
        //         echo "This is the terraform destroy job"
        //     }

        // }
    }
}