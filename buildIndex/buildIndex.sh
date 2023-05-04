#!/bin/bash

echo "`date` Running buildIndex with the following parameters:"
echo "TS_APP_DOMAIN: ${TS_APP_DOMAIN}"
echo "MASTERCATALOG: ${MASTERCATALOG}"
echo "SPIUSER: ${SPIUSER}"
echo ""

python3 -u ${SCRIPT_DIR}/triggerBuildIndex.py ${TS_APP_DOMAIN} ${MASTERCATALOG} ${SPIUSER} ${SPIUSERPASSWORD} ${1}