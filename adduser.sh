#!/bin/bash
# check if user exists already
if [ $(id -u) -eq 0 ]; then
  read -p "Enter username : " username
  read -s -p "Enter password : " password
  egrep "^$username" /etc/passwd >/dev/null
  if [ $? -eq 0 ]; then
    echo "$username exists!"
    exit 1
# Otherwise, create user with pre-salted password
  else
    pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
    useradd -m -p $pass $username
    [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
# Make directory and copy mathpass file
    mkdir -p /home/$username/.Mathematica/Licensing || echo "Failed to create Mathematica license directory"
    cp /root/.Mathematica/Licensing/mathpass /home/$username/.Mathematica/Licensing/mathpass || echo "Failed to copy mathpass file"
# Copy SAS autoexec file into home directory
    cp /root/autoexec.sas /home/$username/autoexec.sas || echo "Failed to copy autoexec.sas"
# force password change on first login
    chage -d 0 $username || echo "chage command failed"
  fi
# Are we root? if not, exit
else
  echo "Only root may add a user to the system"
  exit 2
fi
