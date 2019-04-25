#!/bin/bash
#Author: Natheesh MG
#Purpose: adding users to sudo

read -p "Enter user id: " username
echo "kindly confirm $username need sudo access"
read -p "Enter [Y/N] to proceed: " input
case $input in
    [yY][eE][sS]|[yY])
 echo "Add the user to sudo group."
 ;;
    *)
 echo "Invalid input..."
 exit 0
 ;;
esac
read -p "Enter the username again to confirm: " u
usermod -a -G sysadmins $u
s=`echo $?`
if [ $s = 0 ]
then echo "The user "$u" is a valid user....................."
    elif [ $s != 0 ]
    then echo "Exiting...."
    exit 0
    fi 
lid -g sysadmins| grep $u| cut -f -1 -d "("

echo "The user "$u" is added to sysadmins group.............."
   
read -p "Adding task to cron to revoke root access. Please enter [Y/N]: " input2
case $input2 in
    [yY][eE][sS]|[yY])
 echo "adding................ task to cron"
 ;;
    *)
 echo "Invalid input..."
 exit 0
 ;;
esac
read -p "Proceed CRON setting............... Please enter [Y/N: " c
case $c in
    [yY][eE][sS]|[yY])
 echo "processing..............................."
 ;;
    *)
 echo "Invalid input..."
 exit 0
 ;;
esac
echo "Enter values MIN,HOURS,DOM,DOW,CMD."
read -p "Enter Minutes(0-59): " m
read -p "Entet Hours(0-23): " h
read -p "Enter Day(1-31): " d
read -p "Enter Month(1-12): " mn
read -p "Enter Weekday(0-6): " w
read -p "TYPE "........cron......." to proceed: " cron
crt=`(crontab -l && echo "$m $h $d $mn $w /cron-scripts/cron.sudo.sh") | crontab -`
$crt
