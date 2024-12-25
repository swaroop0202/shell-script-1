#!/bin/bash

SOURCE_DIRECTORY=/tmp/app-logs
R="\e[31m"
G="\e[32m"
W="\e[0m"

if [ -d $SOURCE_DIRECTORY ]
then 
    echo -e "$G source directory exits $W "
else
    echo -e "$R please create $SOURCE_DIRECTORY $W"
    exit 1
fi

FILES=$(find /tmp/app-logs/ -name "*.log" -mtime +14)

while IFS=',' read -r line

do

 echo "deleting file: $line"
 rm -rf $line 

done <<< $FILES