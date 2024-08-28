#!/bin/bash

# Script para criar um novo bucket S3

# Verifica se foi fornecido o nome do bucket como argumento
if [ $# -ne 1 ]; then
    echo "Usage: $0 <bucket-name>"
    exit 1
fi

bucket_name=$1

# Cria o novo bucket no Amazon S3
echo "Criando o bucket '$bucket_name'..."
aws s3 mb "s3://$bucket_name"

# Verifica se o bucket foi criado com sucesso
if [ $? -eq 0 ]; then
    echo "Bucket '$bucket_name' criado com sucesso."
else
    echo "Erro ao criar o bucket '$bucket_name'."
    exit 1
fi
