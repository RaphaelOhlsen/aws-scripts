#!/bin/bash

# Script para gerar URL assinada para acesso a arquivo em um bucket S3

# Verifica se foram fornecidos corretamente os argumentos
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <bucket-name> <object-key> [<expires-in-seconds>]"
    exit 1
fi

bucket_name=$1
object_key=$2

# Define o tempo de expiração padrão (1 hora em segundos)
expires_in=3600

# Se um terceiro argumento foi especificado, define o tempo de expiração
if [ $# -eq 3 ]; then
    expires_in=$3
fi

# Gera a URL assinada com o tempo de expiração especificado
presigned_url=$(aws s3 presign s3://$bucket_name/$object_key --expires-in $expires_in)

# Exibe a URL assinada
echo "URL assinada para acesso ao objeto s3://$bucket_name/$object_key válida por $expires_in segundos:"
echo $presigned_url
