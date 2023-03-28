import boto3
import sys

regions=['us-east-1','eu-central-1']
first=False
for region in regions:
    rds_client=boto3.client('rds',region_name=region)
    user_client=boto3.client('iam')

    rds=rds_client.describe_db_instances()
    users=user_client.list_users()

    account_id=users['Users'][0]['Arn'].split(':')[4]
    base_arn='arn:aws:rds:%s:%d:db:'%(region,int(account_id))
    print(f'Account:{account_id} & Region:{region}')
    for instance in rds['DBInstances']:
        instance_name=instance['DBInstanceIdentifier']
        resource=base_arn+instance_name
        print("====RDS_Name:{}=====".format(instance_name))
        if first == True:
            new_environment_tag={"Key":"env","Value":instance_name}
            new_refresh_tag={"Key":"refresh_from","Value":"NA"}
            response=rds_client.add_tags_to_resource(ResourceName=resource,Tags=[new_environment_tag,new_refresh_tag])
            print(response)
            continue

        tags=rds_client.list_tags_for_resource(ResourceName=resource)['TagList']
        for value in tags:
            if value['Key'] =='env':
               environment_tag=value["Value"]
            elif value['Key'] =="refresh_from":
               refresh_tag=value['Value']
        if "new" in instance_name.lower() or "old" in instance_name.lower():
            print("DB restore is in progress for {}",format(instance_name))
        elif instance_name != environment_tag:
            print("DB refreshed for {} from {}".format(instance_name,environment_tag))
            new_environment_tag={"Key":"env","Value":instance_name}
            new_refresh_tag={"Key":"refresh_from","Value":environment_tag}
            rds_client.add_tags_to_resource(ResourceName=resource,Tags=[new_refresh_tag,new_environment_tag])
        else:
            print(f"DB is not refreshed for {environment_tag}")
            print(f'{environment_tag} is refreshed from {refresh_tag}')
