#!/bin/bash

ls -ltr

if [ $? -ne 0 ]; then

echo "Previous command is failure"
exit 1

else 

echo "Programm is success at: $(date)"
fi

#echo "Program is success"