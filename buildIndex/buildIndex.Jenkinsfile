//remove /v1 from the VAULT_URL global parameter
def vaultUrl = env.VAULT_URL.indexOf('/v') > -1 ? env.VAULT_URL.substring(0,env.VAULT_URL.indexOf('/v')) : env.VAULT_URL
def configuration = [vaultUrl: vaultUrl, vaultCredentialId: 'vault-token-credential', engineVersion: 1]
def tenant = 'hp2b'
def secretPrefix = tenant+'/'+env.ENVIRONMENT+'/'+env.ENVTYPE
def secrets = [
	[path: secretPrefix+'/spiUserName',  secretValues: [[envVar: 'SPIUSER', vaultKey: 'value']]],
    [path: secretPrefix+'/spiUserPassword', secretValues: [[envVar: 'SPIUSERPASSWORD', vaultKey: 'value']]]
]

pipeline {

	agent any

	parameters {	
	    string(name: 'ENVIRONMENT', defaultValue: 'dev1', description: 'Environment')
		choice(name: 'ENVTYPE', choices: ['auth', 'live'], description: 'Environment Type')
	    choice(name: 'DELTA_INDEX', choices: ['true', 'false'])
        string(name: 'TS_APP_DOMAIN', defaultValue: 'ts-app-hp2b-dev1auth.corp.hpicloud.net', description: 'TS App Domain')
	}

	environment {
		MASTERCATALOG='10001'
		SCRIPT_DIR='workspace/BuildAndDeploy/UtilityJobs/buildIndex'
	}

	stages {
		stage('Execute buildindex - full') {
			when {
				expression { env.DELTA_INDEX == 'false' }
			}
			steps {
				withVault([configuration: configuration, vaultSecrets: secrets]) {
					echo 'Execute buildindex'
					sh 'chmod +x ${SCRIPT_DIR}/buildIndex.sh'
					sh './${SCRIPT_DIR}/buildIndex.sh'
				}
			}
		}
		stage('Execute buildindex - delta') {
			when {
				expression { env.DELTA_INDEX == 'true' }
			}
			steps {
				withVault([configuration: configuration, vaultSecrets: secrets]) {
					echo 'Execute buildindex'
					sh 'chmod +x ${SCRIPT_DIR}/buildIndex.sh'
					sh './${SCRIPT_DIR}/buildIndex.sh --delta'
				}
			}
		}
	}
	
	post {
		failure {
			emailext from: 'jenkins@hp.com', to: '$DEFAULT_RECIPIENTS', subject: '$DEFAULT_SUBJECT', body: '$DEFAULT_CONTENT'
		}
	}
}
