#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=6

while IFS= read -r line
do
    usage=$(echo $line | awk -F " " '(print $6F)' | cut -d "%" -f1 )
    folder=$(echo $line |awk -F " " '(print $NF)')
    if [ $usage -ge $DISK_THRESHOLD ]
    then
        echo "$usage is more than $DISK_TRESHOLD, current usage is $usage"
    fi
done <<< $DISK_USAGE