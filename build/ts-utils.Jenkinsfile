pipeline {

	agent any

	environment {
		WCB_APP_TYPE="web"
		DOCKER_ECR_ROOT = "${sh(script: 'echo "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"', returnStdout: true).trim()}"
		DOCKER_IMAGE_NAME="ts-utils"
		
		ROOT_DIR="workspace/BuildAndDeploy/CICD/build"
	}

	stages {

		stage("ECR/Docker login"){ 
			steps {
				sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $DOCKER_ECR_ROOT'

				echo "Pulling images from ECR"
				sh 'docker pull $DOCKER_ECR_ROOT/hcl/ts-utils:9.1.8.1'  
				sh 'docker tag $DOCKER_ECR_ROOT/hcl/ts-utils:9.1.8.1 hcl/ts-utils:9.1.8.1'
			}
		}

		stage("Commerce Docker Image") {
			steps {
				script {
				  def label = "9.1.8.1"
				  def imageName = "${DOCKER_ECR_ROOT}/hp2b/${DOCKER_IMAGE_NAME}:${label}"
				  println "Building docker image ${imageName}"
				  def image = docker.build("${imageName}", "${WORKSPACE}/workspace/BuildAndDeploy/images/${DOCKER_IMAGE_NAME}")
				  image.push("${BRANCH_NAME}")
				}
			}
		}
	}
	
	post {
		failure {
			emailext from: 'jenkins@hp.com', to: '$DEFAULT_RECIPIENTS', subject: '$DEFAULT_SUBJECT', body: '$DEFAULT_CONTENT'
		}
		always{
		cleanWs()
		}
	}
}
