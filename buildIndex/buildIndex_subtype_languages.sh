#!/bin/bash

echo "`date` Running buildIndex with the following parameters:"
echo "TS_APP_DOMAIN: ${TS_APP_DOMAIN}"
echo "MASTERCATALOG: ${MASTERCATALOG}"
echo "LOCALENAME: ${LOCALENAME}"
echo "SPIUSER: ${SPIUSER}"
echo ""

python3 -u ${SCRIPT_DIR}/triggerBuildIndexSubtypeLang.py ${TS_APP_DOMAIN} ${MASTERCATALOG} ${LOCALENAME} ${INDEXTYPE} ${INDEXSUBTYPE} ${SPIUSER} ${SPIUSERPASSWORD} ${1}