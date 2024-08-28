#!/bin/bash

AWS_REGION="us-east-1"
FILTER_NAME="group"
FILTER_VALUES="automacao-cli"

# Obtém os IDs das instâncias rodando
INSTANCE_IDS=$(aws ec2 describe-instances \
  --region $AWS_REGION \
  --filters "Name=tag:$FILTER_NAME,Values=$FILTER_VALUES" "Name=instance-state-name,Values=running,stopped" \
  --query "Reservations[*].Instances[*].[InstanceId]" \
  --output text | tr -d '[],"')

# Parar instâncias rodando, se houver
if [ -n "$INSTANCE_IDS" ]; then
  aws ec2 terminate-instances \
    --instance-ids $INSTANCE_IDS \
    --region $AWS_REGION \
    --output table
else
  echo "Não foram encontradas instâncias rodando ou paradas com a tag $FILTER_NAME=$FILTER_VALUES para terminar."
fi

