#!/bin/sh

#Getting the created load balancer and deleting it
#elb_name=$(aws elb describe-load-balancers --query "LoadBalancerDescriptions[].LoadBalancerName" --region us-east-1 --output text)
#aws elb delete-load-balancer --load-balancer-name $elb_name

# Getting the created subnets and deleting it
subnet_ids=$(aws ec2 describe-subnets --filters "Name=tag-key,Values='kubernetes.io/role/elb'" --query "Subnets[].SubnetId" --output text)

for subnet_id in $subnet_ids; do
	#aws ec2 delete-subnet --subnet-id $subnet_id
	echo $subnet_id
done

# Getting the created security groups and deleting it
security_groups=$(aws ec2 describe-security-groups --filters "Name=tag-key,Values='aws:eks:cluster-name'" --query "SecurityGroups[].GroupId" --output text)

for security_group_id in $security_groups; do
	# aws ec2 delete-security-group --group-id $security_group_id
	echo $security_group_id
done
