#!/bin/bash

# check if AWS AMI id is entered as input
if [ $0 -eq ""] 
then
echo "please enter AWS image id"
exit 0
fi

#configure AWS environment variables:
echo "please enter aws configuration"
aws configure


#create security group
echo "Creating Security Group"
gid =`aws ec2 create-security-group --group-name levtask-sg  --description "security group for Leverton Task" | | head -2 | tail -1 | cut -d ":" -f 2`
echo "Security Group id " $gid " Created" 

#Enable SSH access to the instance
echo "Enable SSH access to the intance"
aws ec2 authorize-security-group-ingress --group-name levtask-sg --protocol tcp --port 22 --cidr 0.0.0.0/0


#create key-pair
echo "Created Keypair"
aws ec2 create-key-pair --key-name levtask-key --query 'KeyMaterial' --output text > levtask-key.pem
chmod 400 levtask-key.pem

#start and launch the instance and run the bootstrap file
inst_id=`aws ec2 run-instances  --security-group-ids $gid  --image-id $0 --count 1 --instance-type t2.micro --key-name levtask-key.pem --user-date file://bootstrap.sh`


# get instance IP address
inst_ip=`aws ec2 describe-instances --instance-ids $inst_id --query 'Reservations[0].Instances[0].PublicIpAddress'`

echo "Instance Puplic IP Address is "$inst_ip 



