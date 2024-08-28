#!/bin/bash

# Script para listar conteúdo de um bucket S3 específico

# Verifica se foi fornecido o nome do bucket como argumento
if [ $# -ne 1 ]; then
    echo "Usage: $0 <bucket-name>"
    exit 1
fi

bucket_name=$1

# Verifica se o bucket existe usando aws s3 ls
if aws s3 ls "s3://$bucket_name" 2>&1 | grep -q 'NoSuchBucket'; then
    echo "O bucket '$bucket_name' não foi encontrado."
else
    # Executa o comando aws s3 ls para listar objetos no bucket especificado
    aws s3 ls "s3://$bucket_name"
fi
