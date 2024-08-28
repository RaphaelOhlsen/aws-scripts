#!/bin/bash

if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <local-file-path> <bucket-name> [<storage-class>]"
    exit 1
fi

local_file_path=$1
bucket_name=$2
storage_class=$3

if [ ! -f "$local_file_path" ]; then
    echo "Arquivo '$local_file_path' não encontrado."
    exit 1
fi

file_name=$(basename "$local_file_path")

default_storage_class="STANDARD"

upload_command="aws s3 cp"

if [ ! -z "$storage_class" ]; then
    upload_command+=" --storage-class $storage_class"
else
    upload_command+=" --storage-class $default_storage_class"
fi

upload_command+=" \"$local_file_path\" \"s3://$bucket_name/$file_name\""


echo "Fazendo upload de $local_file_path para s3://$bucket_name/$file_name ..."

eval $upload_command

if [ $? -eq 0 ]; then
    echo "Upload concluído com sucesso."
else
    echo "Erro ao fazer upload."
    exit 1
fi
