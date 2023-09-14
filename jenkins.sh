#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

DATE=$(date +%F)
LOG="jenkins-install-${DATE}.log"

VALIDATE(){
if [ $? -ne 0 ]; then
	echo "${R}====$2==== is Failure${N}" 2>&1 | tee -a $LOG
	exit 1
else 
	echo "${G}====$2=== is Success${N}" 2>&1 | tee -a $LOG
fi
}

if [ $USERID -ne 0 ]; then
        echo "${R}You need to be root user to execute this script${N}"
        exit 1
fi

apt-get update -y

VALIDATE $? "Updating apt"

 curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null 

 VALIDATE $? "Jenkins Key"

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null  

VALIDATE $? "Adding Jenkins Repo"

 sudo apt-get update 

 VALIDATE $? "Updating Apt-get"

 sudo apt-get install fontconfig openjdk-11-jre -y
 VALIDATE $? "Installing JRE"

  sudo apt-get install jenkins -y  
  VALIDATE $? "Jenkins Installation"

  service jenkins start 
  VALIDATE $? "Jenkins Start"





