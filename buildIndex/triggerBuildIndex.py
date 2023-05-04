import os
import sys
import json
import datetime
import time
import argparse
import requests
from requests import Request,Session
from requests.auth import HTTPBasicAuth
import urllib3

urllib3.disable_warnings()

# Get ts url from args
cmd_parser = argparse.ArgumentParser()
cmd_parser.add_argument("domain", help="ts-app domain name")
cmd_parser.add_argument("masterCatalogId", help="master catalog ID to build index")
cmd_parser.add_argument("spiuser", help="spiuser username")
cmd_parser.add_argument("spipwd", help="spiuser password")
cmd_parser.add_argument("--delta", help="run delta build index instead of full", action="store_true")

args = cmd_parser.parse_args()
ts_auth = HTTPBasicAuth(args.spiuser, args.spipwd)

# Connect ts-server to get jobStatusID
index_url = "https://"+args.domain+"/wcs/resources/admin/index/dataImport/build?masterCatalogId="+args.masterCatalogId
if args.delta:
    index_url = index_url + "&fullBuild=false"

print("Requesting Index URL: {}".format(index_url))
ts_r = requests.post(url=index_url, data={}, auth=ts_auth, verify=False)
content = ts_r.json()
statusID = content['jobStatusId']
print("Received job status ID: {}".format(statusID))

status_url = "https://"+args.domain+"/wcs/resources/admin/index/dataImport/status?jobStatusId="+statusID

count = 1
while count <= 240:
    print("Waiting for 5 minutes...")
    time.sleep(300)

    print("Requesting URL: {}".format(status_url))
    search_r = requests.get(url=status_url, auth=ts_auth, verify=False)
    progress = search_r.json()

    statholder = progress['status']
    message = statholder['message']
    curstat = int(statholder['status'])
    startTime = statholder['startTime']
    if startTime:
        startTimeObj = datetime.datetime.strptime(startTime, '%Y-%m-%d %H:%M:%S.%f')
    finishTime = statholder['finishTime']
    if finishTime:
        finishTimeObj = datetime.datetime.strptime(finishTime, '%Y-%m-%d %H:%M:%S.%f')
    currentTime = time.ctime(time.time())

    print(currentTime)
    print("Iteration: {}\n- Status: {}\n- Start time: {}\n- Finish time: {}\n- Message: {}\n".format(count, curstat, startTime, finishTime, message))

    count += 1

    if int(curstat) == 0:
        print("Job completed successfully")
        break
    elif int(curstat) == -1:
        print("Indexing job is still in progress.")
    else:
        print("Error occurred. Please check Transaction/Search server logs and try again.")
        sys.exit(int(curstat))

else:
    print("Job timed out after 20 hours, however it may still be running on the servers. Please check Transaction/Search server logs and try again.")
