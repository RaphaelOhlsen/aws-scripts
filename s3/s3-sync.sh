#!/bin/bash
# Verifica se foram fornecidos corretamente os argumentos
if [ $# -ne 2 ]; then
    echo "Usage: $0 <local-directory> <bucket-name>"
    exit 1
fi

local_dir=$1
bucket_name=$2

# Verifica se o diretório local existe
if [ ! -d "$local_dir" ]; then
    echo "Diretório '$local_dir' não encontrado."
    exit 1
fi

echo "Sincronizando '$local_dir' com 's3://$bucket_name'..."
aws s3 sync "$local_dir" "s3://$bucket_name"

# Verifica se a sincronização foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Sincronização concluída com sucesso."
else
    echo "Erro durante a sincronização."
    exit 1
fi
