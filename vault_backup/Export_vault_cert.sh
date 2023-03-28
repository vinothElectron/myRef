#!/bin/bash

root_path=$1

jq --null-input --arg root $root_path '{($root):{}}' > vault_cert_"$root_path".json


json_out()
{
        path=$1
          local inner_path=(`vault list $path/certs | tail -n+3`)
          for i in "${inner_path[@]}";
          do
                key_value=`vault read --format json $path/cert/$i | jq '.data' | tr -d '\n '`
                echo "certificate-name:$path/cert/$i"
                echo "certificate:$key_value"
                out=`jq '.'$path'."'$i'" +='$key_value'' vault_cert_"$root_path".json`
                echo $out | jq . > vault_cert_"$root_path".json

          done
}
json_out $root_path
echo "completed"
