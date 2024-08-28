#!/bin/bash

# Definir variáveis
IMAGE_ID="ami-06c68f701d8090592"
COUNT=1
INSTANCE_TYPE="t3.micro"
KEY_NAME="awsKey"
SECURITY_GROUP_ID="sg-03157c503eb4c4fe4"
SUBNET_ID="subnet-0825a3723659dd7e2"
AWS_REGION="us-east-1"
TAG_KEY="group"
TAG_VALUE="automacao-cli"
USER_DATA_FILE="1-scripts-ecs.sh"

# Executar o comando com as variáveis
aws ec2 run-instances \
  --image-id $IMAGE_ID \
  --count $COUNT \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --region $AWS_REGION \
  --tag-specifications "ResourceType=instance,Tags=[{Key=$TAG_KEY,Value=$TAG_VALUE}]"