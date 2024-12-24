#!/bin/bash

USERID=$(id -u)

if [ $? -ne 0 ]
then 
    echo "please run with the root user"
    exit 1
else
    echo "you are a super user"
fi

echo "SCRIPTNAME: $0 | cut -d "." -f1"