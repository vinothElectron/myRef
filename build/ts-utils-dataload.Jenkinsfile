pipeline {

	agent any

	environment {
		WCB_APP_TYPE="utils"
		DOCKER_ECR_ROOT = "${sh(script: 'echo "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"', returnStdout: true).trim()}"
		DOCKER_IMAGE_NAME="ts-utils"
		DATALOAD_DIR="workspace/BuildAndDeploy/images/ts-utils-dataload/SETUP/Dataload"
		ROOT_DIR="workspace/BuildAndDeploy/CICD/build"
	}

	stages {

		stage("ECR/Docker login"){ 
			steps {
				sh 'source ~/.bash_profile; aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $DOCKER_ECR_ROOT'

				echo "Pulling images from ECR"
				sh 'docker pull $DOCKER_ECR_ROOT/hcl/ts-utils:9.1.8.1'  
				sh 'docker tag $DOCKER_ECR_ROOT/hcl/ts-utils:9.1.8.1 hcl/ts-utils:9.1.8.1'
			}
		}
		
		stage('Include Dataload projects') {
		
			steps {
				sh "rm -rf ${DATALOAD_DIR}"
				sh "mkdir ${DATALOAD_DIR}"
				echo "start copying dataload projects..."
						
				fileOperations(
					[fileCopyOperation(
						flattenFiles: false, 
						includes: 'workspace/Dataload/**/*', 
						targetLocation: "${DATALOAD_DIR}")])
						
			   echo "copied dataload projects"
						
			}
			
		}

		stage("Commerce Docker Image") {
			steps {
				script {
				  def label = env.BRANCH_NAME == "master" ? "latest":env.BRANCH_NAME
				  def imageName = "${DOCKER_ECR_ROOT}/hp2b/${DOCKER_IMAGE_NAME}:${label}"
				  println "Building docker image ${imageName}"

				  def image = docker.build("${imageName}", "${WORKSPACE}/workspace/BuildAndDeploy/images/${DOCKER_IMAGE_NAME}-dataload")
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
