#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "please run this script with root user"
else
    echo "you are a root user"
fi

SCRIPTNAME=$(echo $0 | cut -d "." -f1)