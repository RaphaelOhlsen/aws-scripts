#!/bin/bash

# Script para fazer download de um arquivo de um bucket S3

# Verifica se foram fornecidos corretamente os argumentos
if [ $# -ne 3 ]; then
    echo "Usage: $0 <bucket-name> <object-key> <local-download-path>"
    exit 1
fi

bucket_name=$1
object_key=$2
local_download_path=$3

# Faz o download do arquivo do bucket S3 para o caminho local especificado
echo "Fazendo download de s3://$bucket_name/$object_key para $local_download_path ..."
aws s3 cp "s3://$bucket_name/$object_key" "$local_download_path"

# Verifica se o download foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Download concluído com sucesso."
else
    echo "Erro ao fazer download."
    exit 1
fi
