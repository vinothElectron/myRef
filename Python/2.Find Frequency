#Scan the log file for POST requests and create a summary in CSV format that lists each
#unique IP address and the number of POST requests corresponding to that IP address.
#- The example Log file:
#10.0.0.153 - - [10/Mar/2014:12:05:40 -0800] "GET /icons/gnu-head-tiny.jpg HTTP/1.1" 304 -
#10.0.0.153 - - [10/Mar/2014:12:05:40 -0800] "GET /icons/PythonPowered.png HTTP/1.1" 304 -
#10.0.0.153 - - [10/Mar/2014:12:05:54 -0800] "POST /mailman/admin/ppwc/members?letter=p HTTP/1.1" 200 23169
#output
# 10.0.0.153, 1

import os
from collections import defaultdict
print(os.path.abspath(r"C:\Users\dell\Desktop\New\Sample_01.txt"))
file_path=r"C:\Users\dell\Desktop\New\Sample_01.log"

IP_count=defaultdict(int)
with open(file_path,'r') as file:
    for line in file:
        fields=line.strip().split()
        if len(fields)>1 and fields[5].lstrip("\"").upper() == "POST":
            IP_count[fields[0]]+=1;

for k,v in IP_count.items():
    print(f'{k}, {v}')
