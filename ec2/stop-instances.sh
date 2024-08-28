#!/bin/bash

AWS_REGION="us-east-1"
FILTER_NAME="group"
FILTER_VALUES="automacao-cli"

# Obtém os IDs das instâncias rodando
INSTANCE_IDS=$(aws ec2 describe-instances \
  --region $AWS_REGION \
  --filters "Name=tag:$FILTER_NAME,Values=$FILTER_VALUES" "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].[InstanceId]" \
  --output text | tr -d '[],"')

# Verifica se há instâncias rodando
if [ -n "$INSTANCE_IDS" ]; then
  # Se houver instâncias rodando, para as instâncias encontradas
  aws ec2 stop-instances \
    --instance-ids $INSTANCE_IDS \
    --region $AWS_REGION \
    --output table
else
  # Se não houver instâncias rodando, informa ao usuário
  echo "Não foram encontradas instâncias rodando com a tag $FILTER_NAME=$FILTER_VALUES."
fi
