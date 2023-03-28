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

import(){
        local base_path=$1
        local current_path=$2
        local total_path=""

        #echo "base =$base_path   current=$current_path"
        if [[ -z "$base_path" || -z "$current_path" ]];then
                total_path=$base_path$current_path
        else
                total_path=$base_path.$current_path
        fi
        #echo "total==$total_path"
        jq  '.'$total_path' | keys[]' $json_file 2>&1 >/dev/null
        if [ $? != 0 ];
        then
                value=`jq  '.'$base_path'' $json_file`
                echo  "$base_path ==> $value"
                array_value=(`echo $value|jq '.|keys[]'`)
                for key in "${array_value[@]}";do
                        ivalue=`echo $value|jq '.'$key |sed 's|\"||g'`
                        ikey=`echo $key|sed 's|\"||g'`
                        put_path=`echo $base_path|sed 's|"."|/|g;s|\"||g'`
                        #vault kv put $put_path $ikey=$ivalue
                        echo "$put_path -->$ikey=$ivalue"
                done

        else
                #echo "inner:$base_path"
                jq -c '.'$total_path' |keys[]' $json_file  |while read i;do
                        import $total_path $i
                done

        fi

}
