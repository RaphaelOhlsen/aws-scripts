#!/bin/bash

AWS_REGION="us-east-1"
FILTER_NAME="group"
FILTER_VALUES="automacao-cli"

# Obtém os IDs das instâncias paradas
INSTANCE_IDS=$(aws ec2 describe-instances \
  --region $AWS_REGION \
  --filters "Name=tag:$FILTER_NAME,Values=$FILTER_VALUES" "Name=instance-state-name,Values=stopped" \
  --query "Reservations[*].Instances[*].[InstanceId]" \
  --output text | tr -d '[],"')

# Verifica se há instâncias paradas
if [ -n "$INSTANCE_IDS" ]; then
  # Se houver instâncias paradas, inicia as instâncias encontradas
  aws ec2 start-instances \
    --instance-ids $INSTANCE_IDS \
    --region $AWS_REGION \
    --output table
else
  # Se não houver instâncias paradas, informa ao usuário
  echo "Não foram encontradas instâncias paradas com a tag $FILTER_NAME=$FILTER_VALUES para iniciar."
fi
