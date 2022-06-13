pipeline {
    agent any

    stages {
        stage('Pull Sourcecode from GITHUB') {
            steps {
                git branch: 'main', url: 'https://github.com/zafar-khan123/declarative-pipeline.git'
            }
        }
        
        stage('Build docker image'){
            steps{
                sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                sh 'docker image tag $JOB_NAME:v1.$BUILD_ID zk0034630/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image tag $JOB_NAME:v1.$BUILD_ID zk0034630/$JOB_NAME:latest'
            }
        }
        
        stage('Push docker image into DockerHUB'){
            steps{
                withCredentials([string(credentialsId: 'dockerhubpassword1', variable: 'dockerhubpassword')]) {
                // some block
                sh 'docker login -u zk0034630 -p ${dockerhubpassword}'
                sh 'docker image push zk0034630/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image push zk0034630/$JOB_NAME:latest'
                sh 'docker image rmi $JOB_NAME:v1.$BUILD_ID zk0034630/$JOB_NAME:v1.$BUILD_ID zk0034630/$JOB_NAME:latest'
                }
            }
        }
        
        stage('Container deployment in Docker-HOST'){
            // def dockerrm = 'docker container rm -f cloudknowledge'
            // def dockerimagerm = 'docker image rmi zk0034630/pipeline-demo'
            
            
            steps{
                def dockerrun = 'docker run -p 8000:80 -d - -name cloudknowledge zk0034630/pipeline-demo:latest'
                sshagent(['dockerhostid']) {
                // some block
                sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.40.237 ${dockerrun}"
                }
            
            }
        }
    }
}

