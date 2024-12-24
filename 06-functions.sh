#!/bin/bash

USERID=$(id -u)

SCRIPTNAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$( date +%F-%H-%M-%S)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
W="\e[0m"


if [ $USERID -ne 0 ]
then 
    echo "please run this script with root user"
else
    echo "you are a root user"
fi

VALIDATE() {
    if [ $1 -ne 0 ]
then 
    echo -e "$2 ...$R failure $W"
else
    echo -e "$2...$G success $W"
fi

}

dnf install mysql-server -y &>>$LOGFILE
VALIDATE "$?" "installation of mysql" 

systemctl enable mysqld 
VALIDATE "$?" "enabling mysqld"

systemctl start mysqld
VALIDATE "$?" "starting mysqld"

mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE "$?" "setting up root password"


