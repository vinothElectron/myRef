pipeline {

	agent any
	options{timestamps()}
	environment {
		WCB_APP_TYPE = 'ts'
		DOCKER_ECR_ROOT = "${sh(script: 'echo "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"', returnStdout: true).trim()}"
		DOCKER_IMAGE_NAME = 'ts-app'
	}

	stages {
		stage('ECR/Docker login'){ 
			steps {
				sh 'source ~/.bash_profile;  aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $DOCKER_ECR_ROOT'

				echo "Pulling images from ECR"
				sh 'docker pull $DOCKER_ECR_ROOT/hp2b/ts-utils:9.1.8.1'  
				sh 'docker tag $DOCKER_ECR_ROOT/hp2b/ts-utils:9.1.8.1 hp2b/ts-utils:9.1.8.1'

				sh 'docker pull $DOCKER_ECR_ROOT/hcl/ts-app:9.1.8.1'  
				sh 'docker tag $DOCKER_ECR_ROOT/hcl/ts-app:9.1.8.1 hcl/ts-app:9.1.8.1'
			}
		}

		stage('Run WC Build in Docker') {
			agent { 
				dockerfile {
					dir 'workspace/BuildAndDeploy'
					reuseNode true
					args  '-u root -v ${WORKSPACE}:/opt/build -e APP_TYPE=${WCB_APP_TYPE} -e BRANCH_NAME=${BRANCH_NAME} -e BUILD_NUMBER=${BUILD_NUMBER} -m 4g'
				}
			}
			steps {
				sh '/build/build.sh'
			}
		}

		stage('Unzip WCB package') {
			steps {
				echo "Cleaning ${WORKSPACE}/workspace/BuildAndDeploy/images/${DOCKER_IMAGE_NAME}/SETUP/CusDeploy"
				sh  "if [ -d ${WORKSPACE}/workspace/BuildAndDeploy/images/${DOCKER_IMAGE_NAME}/SETUP/CusDeploy ]; then rm -rf ${WORKSPACE}/workspace/BuildAndDeploy/images/${DOCKER_IMAGE_NAME}/SETUP/CusDeploy/*; fi"

				echo "Unzipping WCB package ${WORKSPACE}/${BUILD_NUMBER}/package/wcbd-deploy-server-local-${WCB_APP_TYPE}-${BRANCH_NAME}.zip"
				sh  "unzip -o -q ${WORKSPACE}/${BUILD_NUMBER}/package/wcbd-deploy-server-local-${WCB_APP_TYPE}-${BRANCH_NAME}.zip -d ${WORKSPACE}/workspace/BuildAndDeploy/images/${DOCKER_IMAGE_NAME}/SETUP/CusDeploy"
			}
		}

		stage('Commerce Docker Image') {
			steps {
				script {
				  def label = env.BRANCH_NAME == "master" ? "latest":env.BRANCH_NAME
				  def imageName = "${DOCKER_ECR_ROOT}/hp2b/${DOCKER_IMAGE_NAME}:${label}"
				  println "Building docker image ${imageName}"

				  def image = docker.build("${imageName}", "${WORKSPACE}/workspace/BuildAndDeploy/images/${DOCKER_IMAGE_NAME}")
				  image.push("${BRANCH_NAME}")
				}
			}
		}
		
		stage('Remove WCB package') {
			steps {
				echo "Removing ${WORKSPACE}/${BUILD_NUMBER}/package/wcbd-deploy-server-local-${WCB_APP_TYPE}-${BRANCH_NAME}.zip"
				sh  "if [ -f  ${WORKSPACE}/${BUILD_NUMBER}/package/wcbd-deploy-server-local-${WCB_APP_TYPE}-${BRANCH_NAME}.zip ]; then sudo rm -f ${WORKSPACE}/${BUILD_NUMBER}/package/wcbd-deploy-server-local-${WCB_APP_TYPE}-${BRANCH_NAME}.zip; fi"

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
