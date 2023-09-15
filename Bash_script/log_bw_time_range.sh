########################
#sample Log:	  
    #[9/7/23 4:19:34:585 GMT] 000006df HPCatalogEntr I   HP_FETCH_ATTR_VALUE > Executing Query with parameters > is3pp | -26 | 30
    #[9/7/23 4:19:34:589 GMT] 000006df HPCatalogEntr I   query to be executedSELECT A.CATENTRY_ID,C.VALUE,A.ATTR_ID FROM CATENTRYATTR A JOIN ATTRVALDESC C ON C.ATTRVAL_ID=A.ATTRVAL_ID WHERE A.ATTR_ID IN (?) AND A.ATTR_ID=C.ATTR_ID AND C.LANGUAGE_ID=? AND A.CATENTRY_ID IN (?,?)
#sample input:
    #startDate: 9/7/23 4:18:00
    #endDate: 9/7/23 4:19:59
########################
#!/bin/bash
echo "Enter dates in mm/dd/yy HH:MM:SS Timezone, example 9/13/23 10:50:26"
read -p "StartDate : " StartDate
read -p "EndDate : " EndDate
StartDate=$(date -d "$StartDate" +%s)
EndDate=$(date -d "$EndDate" +%s)

logfile="/tmp/pts_1_SystemOut.log"
awk -v start=$StartDate -v end=$EndDate '
{
        # take 1t two fields, ie.., timestamp (expected output: [9/7/23 4:18:59:266)
        timestamp= $1 " " $2
        gsub("\\[","",timestamp)  # remove front square box
        gsub(":[0-9]{3}","",timestamp) # remove last 3 digit number along with last colon
        split(timestamp,array1,"[// :]") # split timestamp by /," ",: & store it in array1 variable
        #print "20" array1[3] " " array1[1] " " array1[2] " " array1[4] " " array1[5] " " array1[6]
        logtos = mktime("20" array1[3] " " array1[1] " " array1[2] " " array1[4] " " array1[5] " " array1[6]) #convert timestamp into seconds (mktime(YYYY mm dd HH MM SS))
        #print strftime("%Y-%m-%d %H:%M:%S",logtos)
        #print strftime("%Y-%m-%d %H:%M:%S",start)
        #print logtos
        if(logtos>=start && logtos<=end){
          print  #print line only if log reside between two time range
        }

}
' "$logfile"
