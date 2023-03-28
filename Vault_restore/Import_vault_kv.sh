#!/bin/bash

json_file=$1
secret_engine=$2
path=""
epath=""


jq . $json_file >/dev/null
if [ $? != 0 ];
then
    error "invalid json"
    exit 0
fi
out=`jq -c . $json_file`
if [ $out == "" ]
then
   error "empty file"
    exit 0
fi
echo "started"

