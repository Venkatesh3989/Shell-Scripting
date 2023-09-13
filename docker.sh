#!/bin/bash
USERID=$(id -u)

if [ $USERID -ne 0 ]; then
	echo "You need to be root user to execute this script"
	exit 1
fi

VALIDATE(){
	if [ $? -ne 0 ]; then
		echo " ====$2==== is FAILURE"
		exit 1
	else
		echo " ====$2==== is SUCCESS"
	fi
   }

	apt update -y
	VALIDATE $? "UPDATE"

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
VALIDATE $? "Docker Installation"

docker run  hello-world
VALIDATE $? "Image Creation"
