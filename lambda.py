import boto3

def stop_auto_scaling_group_and_instances(asg_name):
    # Create an EC2 client
    ec2_client = boto3.client('ec2')

    # Create an Auto Scaling client
    asg_client = boto3.client('autoscaling')

    # Suspend the Auto Scaling Group
    asg_client.suspend_processes(AutoScalingGroupName=asg_name)

    # Retrieve the instances in the Auto Scaling Group
    response = asg_client.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_name])
    instance_ids = [instance['InstanceId'] for instance in response['AutoScalingGroups'][0]['Instances']]

    # Stop the instances
    ec2_client.stop_instances(InstanceIds=instance_ids)

    print("Stopped processes of Auto Scaling Group: " + asg_name)

def lambda_handler(event, context):
    asg_name = "terraform-20230608110353040800000007"
    stop_auto_scaling_group_and_instances(asg_name)
