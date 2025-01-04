#!/bin/bash

DISK_FOLDER=$(df -hT | grep xfs | awk -F " " '{print $7F}'
)

DISK_USAGE=$(df -hT | grep xfs | awk -F " " '{print $6F}' | cut -d '%' -f1
)

DISK_THRESHOLD=6

if [ DISK_USAGE -gt $(DISK_THRESHOLD) ]
then
    echo "$DISK_FOLDER is greater than $DISK_USAGE , current usage=$DISK_USAGE"
else
    echo "$DISK_FOLDER is less  than $DISK_USAGE , current usage=$DISK_USAGE"
