#!/bin/bash


region_status(){
echo ""
Region=$1
printf "__________________________\n\nRegion ==> $1\n__________________________\n\n"
echo ""
#Get all RDS Instances with Tag StatusCheck.
rds_nprod=($(aws rds  describe-db-instances --region $Region --query 'DBInstances[?TagList[?Key==`StatusCheck`]].{RDS_Name:DBInstanceIdentifier,RDS_Tag:TagList[?Key==`StatusCheck`].Value|[0],status:DBInstanceStatus}' --output text| tr ' \t\b' '|'))


#filter [?not_null(Tags[?Key==`StatusCheck`])] &&  [?Tags[?Key==`StatusCheck`]] Both operate in the same manner. These will not give null results.. We can use either \
#Get all EC2 Instances with Tag StatusCheck
#aws ec2 describe-instances --query 'reverse(sort_by(Reservations[].Instances[],&State.Name))[?not_null(Tags[?Key==`StatusCheck`])].{InstanceName:Tags[?Key==`StatusCheck`].Value|[0],InstanceId:InstanceId,Status:State.Name}' --output text
ec2_nprod=($(aws ec2 describe-instances --region $Region --query 'reverse(sort_by(Reservations[].Instances[],&State.Name))[?not_null(Tags[?Key==`StatusCheck`])].{EC2Name:Tags[?Key==`Name`].Value|[0],InstanceId:InstanceId,Status:State.Name,tag:Tags[?Key==`StatusCheck`].Value|[0]}' --output text | tr ' \t\b' '|'))

for i in ${ec2_nprod[*]}
do
        echo "EC2 ==> $i"
        EC2_Status=`echo $i| awk -F '|' '{print $3}'`
        EC2_Name=`echo $i| awk -F '|' '{print $1}'`
        if [ $EC2_Status == 'stopped' ]
        then
                tag=`echo $i| awk -F '|' '{print $4}'`
                RDS=($(aws rds  describe-db-instances --region $Region --query 'DBInstances[].{RDS_Name:DBInstanceIdentifier,status:DBInstanceStatus}' --output text| tr ' \t\b' '|' |grep $tag))
                #EC2=$(aws ec2 describe-instances --region $Region --filters Name=tag-key,Values=StatusCheck Name=tag-value,Values=$tag --query 'Reservations[].Instances[].{EC2Name:Tags[?Key==`Name`].Value|[0],EC2_tag:Tags[?Key==`StatusCheck`].Value|[0],InstanceId:InstanceId,Status:State.Name}' --output text | tr ' \t\b' '|')
                for j in ${RDS[*]}
                do
                  echo "RDS ==> $j"
                  RDS_status=`echo $j|awk -F '|' '{print $2}'`
                  RDS_Name=`echo $j|awk -F '|' '{print $1}'`
                  if [ $RDS_status == "available" ]
                  then
                    echo "EC2 stopped but RDS is Running"
                    Event=$(aws rds describe-events --region $Region --source-identifier $RDS_Name --source-type db-instance --duration 1440  --query Events[0].Message)
                    printf "$RDS_Name" 
                    printf "$RDS_status" 
                    printf "$EC2_Status"
                    printf "$Event"
                    Event=`echo $Event`
                    
                   fi
                   echo $RDS_status
                 done
        fi
        echo ""
done
}
region_status "us-east-1"
region_status "eu-central-1"
