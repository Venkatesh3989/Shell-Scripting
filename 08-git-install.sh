#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then

echo "You need to be root user to execute this script"
exit 1
fi

apt-get install git-core -y 

if [ $? -ne 0 ]; then

echo " Installing Git is failed"
exit 2

 else
 echo " Git Installed successfully...!"
  fi