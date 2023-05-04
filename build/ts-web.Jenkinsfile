pipeline {

	agent any

	environment {
		WCB_APP_TYPE="web"
		DOCKER_ECR_ROOT = "${sh(script: 'echo "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"', returnStdout: true).trim()}"
		DOCKER_IMAGE_NAME="ts-web"
		
		ROOT_DIR="workspace/BuildAndDeploy/CICD/build"
		STATIC_WEB_DIR="workspace/BuildAndDeploy/images/ts-web/SETUP/StaticWeb"
	}

	stages {

		stage("ECR/Docker login"){ 
			steps {
				sh 'source ~/.bash_profile; aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $DOCKER_ECR_ROOT'

				echo "Pulling images from ECR"
				sh 'docker pull $DOCKER_ECR_ROOT/hp2b/ts-utils:9.1.8.1'  
				sh 'docker tag $DOCKER_ECR_ROOT/hp2b/ts-utils:9.1.8.1 hp2b/ts-utils:9.1.8.1'

				sh 'docker pull $DOCKER_ECR_ROOT/hcl/ts-web:9.1.8.0'  
				sh 'docker tag $DOCKER_ECR_ROOT/hcl/ts-web:9.1.8.0 hcl/ts-web:9.1.8.0'
			}
		}

		stage("Run WC Build in Docker") {
			agent { 
				dockerfile {
					dir "workspace/BuildAndDeploy"
					reuseNode true
					args  "-u root -v ${WORKSPACE}:/opt/build -e APP_TYPE=${WCB_APP_TYPE} -e BRANCH_NAME=${BRANCH_NAME} -e BUILD_NUMBER=${BUILD_NUMBER}"
				}
			}
			steps {
				sh "/build/build.sh"
			}
		}

		stage("Copy Static Files") {
			steps {
				sh "rm -rf ${STATIC_WEB_DIR}"
				
				fileOperations(
					[fileCopyOperation(
						excludes: '**/*.jsp, **/*.jspf, **/*.properties, **/WEB-INF/**/*, **/META-INF/**/*', 
						flattenFiles: false, 
						includes: 'workspace/Stores/WebContent/**/*', 
						targetLocation: "staticweb")])
						
				fileOperations(
					[fileRenameOperation(
						source: "staticweb/workspace/Stores/WebContent", 
						destination: "${STATIC_WEB_DIR}")])
						
				 sh "rm -rf staticweb"
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
