pipeline {

        agent {label 'master'} 

        stages{
                stage('Pre Environment Creation Steps'){
                        steps{
                                echo 'copying sh files from /opt/JenkinsHome/workspace/ENV_Creation/FullAutomation/ to /opt/WCS9/Environment_Creation'
                                sh "cp -p /opt/JenkinsHome/workspace/ENV_Creation/FullAutomation/* /opt/WCS9/Environment_Creation"
                                sh "chmod 777 /opt/WCS9/Environment_Creation/*";
                                sh "chown wcsadmin:wcsadmin /opt/WCS9/Environment_Creation/*";
                                sh "dos2unix /opt/WCS9/Environment_Creation/*"
                                }
                }

                stage('Master EC2 Creation'){
                        steps {
								echo 'Step 1 : Master EC2 Creation'
								sh "su -c '/opt/WCS9/Environment_Creation/1_MasterEC2_Creation.sh' wcsadmin";
                                }
                }
                stage('EKS Creation'){
                        steps {
                                echo 'Step 2 : EKS Creation'
								sh "ssh wcsadmin@\$(grep Ec2Hostname /opt/WCS9/Environment_Creation/EC2_Details.txt | awk -F '=' '{print \$2}') 'sh /opt/WCS9/Env_Creation_Scripts/2_EKS_Creation.sh' ";
                                }
                }
                stage('Worker Node Creation'){
                        steps {
                                echo 'Step 3 : Worker Node Creation'
								sh "ssh wcsadmin@\$(grep Ec2Hostname /opt/WCS9/Environment_Creation/EC2_Details.txt | awk -F '=' '{print \$2}') 'sh /opt/WCS9/Env_Creation_Scripts/3_Worker_Node_Creation.sh' ";
                                }
                }
                stage('Helm and Vault Installation'){
                        steps {
                                echo 'Step 4 : Helm and Vault Installation'
								sh "ssh wcsadmin@\$(grep Ec2Hostname /opt/WCS9/Environment_Creation/EC2_Details.txt | awk -F '=' '{print \$2}') 'sh /opt/WCS9/Env_Creation_Scripts/4_Helm_Vault_Installation.sh' ";
                                }
                }
                stage('PVC and Ingress Creation'){
                        steps {
                                echo 'Step 5 : PVC and Ingress Creation'
								sh "ssh wcsadmin@\$(grep Ec2Hostname /opt/WCS9/Environment_Creation/EC2_Details.txt | awk -F '=' '{print \$2}') 'sh /opt/WCS9/Env_Creation_Scripts/5_PVC_Ingress_Creation.sh' ";
                                }
                }

        }
}
