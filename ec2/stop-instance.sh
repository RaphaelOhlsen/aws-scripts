#!/bin/bash

# Verificar se o ID da instância foi fornecido como argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <instance-id>"
  exit 1
fi

# Definir variáveis
INSTANCE_ID="$1"
AWS_REGION="us-east-1"

# Parar a instância
aws ec2 stop-instances \
  --instance-ids $INSTANCE_ID \
  --region $AWS_REGION \
  --output table