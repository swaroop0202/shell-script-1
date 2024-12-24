#!/bin/bash

USERID=$(id -u)

SCRIPTNAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$( date +%F-%H-%M-%S)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log

if [ $USERID -ne 0 ]
then 
    echo "please run this script with root user"
else
    echo "you are a root user"
fi

VALIDATE() {
    if [ $1 -ne 0 ]
then 
    echo "$2 ...failure"
else
    echo "$2...success"
fi

}

dnf install mysql-serverr -y
VALIDATE "$?" "installation of mysql" 


