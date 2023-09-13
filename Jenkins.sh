#!/bin/bash
USERID=$(id -u)

VALIDATE(){
if [ $? -ne 0 ]; then
	echo "====$2==== is Failure"
	exit 1
else 
	echo "====$2=== is Success"
fi
}

if [ $USERID -ne 0 ]; then
        echo "You need to be root user to execute this script"
        exit 1
fi

apt update -y

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

 sudo apt-get install fontconfig openjdk-11-jre
 VALIDATE $? "Installing JRE"

  sudo apt-get install jenkins
  VALIDATE $? "Jenkins Installation"

  service jenkins start
  VALIDATE $? "Jenkins Start"





