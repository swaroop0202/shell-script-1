#!/bin/bash

USERID=$(id -u)

SCRIPTNAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$( date +%F-%H-%M-%S)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
W="\e[0m"
Y="\e[33m"
echo "enter mysql_rootpassword"
read mysql_rootpassword


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

dnf module disable nodejs -y &>>$LOGFILE
VALIDATE "$?" "disabling nodejs"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE "$?" "enabling nodejs"

dnf install nodejs -y &>>$LOGFILE
VALIDATE "$?" "installing nodejs"

id expense
if [ $? -ne 0 ]
then
    useradd expense
else
    echo -e "user expense already created...$Y SKIPPING $W"
fi

mkdir -p /app &>>$LOGFILE
VALIDATE "$?" "creating a directory"


rm -rf /tmp/*.zip
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE "$?" "downloading the backend code"

cd /app &>>$LOGFILE
VALIDATE "$?" "going into app directory"

rm -rf /app/*



unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE "$?" "unzipping the code"

cd /app

npm install &>>$LOGFILE
VALIDATE "$?" "installing the dependencies"

cp /home/ec2-user/shell-script-1/shell-project/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE "$?" "configuring the backend service"

systemctl daemon-reload &>>$LOGFILE
VALIDATE "$?" "daemon reload"

systemctl start backend &>>$LOGFILE
VALIDATE "$?" "starting the backend app"

systemctl enable backend &>>$LOGFILE
VALIDATE "$?" "enabling the backend app"

dnf install mysql -y &>>$LOGFILE
VALIDATE "$?" "installing the mysql client"

mysql -h 172.31.22.83 -uroot -p${mysql_rootpassword} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE "$?" "loading the schema"