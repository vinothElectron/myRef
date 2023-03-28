#!/bin/bash

root_path=$1

jq --null-input --arg root $root_path '{($root):{}}' > vault_kv_"$root_path".json

#for i in $(vault kv list hp2b | tail -n+3 | tr -d '/');do;done;

json_out()
{
        #if [[ $path == "" ]];then      local path=$1"/";elsepath+=$1;fi
        local path+=$1;
        vault kv list $path >/dev/null 2>&1
        if [ $? != 0 ];
        then
                out_temp=`echo $path |sed 's|/$||;s|\(.*\)/|\1/\"|g;s|/|.|g;s|$|\"|'`  # 1) remove / if present as last charecter 2) replace last splash(/) to /" 3)replace all slash(/) to . 4) add double quote(") to end of the string
                #out_temp=`echo $path |sed 's|/$||;s|/|.|g'`
                key_value=`vault kv get --format json $path | jq '.data'|tr -d '\n '`;
                echo "temp=$out_temp  &&& key_value=$key_value"
                out=`jq '.'$out_temp'|= '$key_value'' vault_kv_"$root_path".json`
                echo $out | jq . > vault_kv_"$root_path".json
        else
                local inner_path=(`vault kv list $path | tail -n+3`)
                for i in "${inner_path[@]}";
                do
                        full_path=$path$i
                        echo "x="$full_path
                        json_out $full_path
                        echo "inner=$inner_path"
                done
        fi
}
root=$root_path"/"
json_out $root
echo "completed"
