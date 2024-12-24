#!/bin/bash

USERID=$(id -u)

SCRIPTNAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$( date +%F-%H-%M-%S)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
W="\e[0m"
Y="\e[33m"



if [ $USERID -ne 0 ]
then 
    echo "please run this script with root user"
    exit 1
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

dnf install nginx -y &>>$LOGFILE
VALIDATE "$?" "installing nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATE "$?" "enbaling nginx"

systemctl start nginx &>>$LOGFILE
VALIDATE "$?" "starting nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE "$?" "removing contents in html directory"

rm -rf /tmp/*.zip &>>$LOGFILE
curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE "$?" "downloading the frontend code"

cd /usr/share/nginx/html &>>$LOGFILE
VALIDATE "$?" "going into html folder"

unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE "$?" "unzipping the code"

cp /home/ec2-user/shell-script-1/shell-project/expense.conf https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE "$?" "configuring the service"

systemctl restart nginx &>>$LOGFILE
VALIDATE "$?" "restarting nginx"