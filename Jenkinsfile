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
                withCredentials([string(credentialsId: 'dochubpassword1', variable: 'dochubpassword')]) {
                // some block
                sh 'docker login -u zk0034630 -p ${dochubpassword}'
                sh 'docker image push zk0034630/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image push zk0034630/$JOB_NAME:latest'
                sh 'docker image rmi $JOB_NAME:v1.$BUILD_ID zk0034630/$JOB_NAME:v1.$BUILD_ID zk0034630/$JOB_NAME:latest'
                }
            }
        }
        
        stage('Deployment on Docker-HOST'){
            steps{
              sshagent(['docremhost']) {
              sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.34.207 docker rm -f cloudknowledge'
              sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.34.207 docker image rmi zk0034630/pipeline-project'
              sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.34.207 docker run -p 8080:80 -td --name cloudknowledge zk0034630/pipeline-project:latest'
              }
            
            }
        }
        
    }
}

