#!/bin/bash
# Script for adding ILO Advanced License to ILO-card

# Authentication to ILO card
USERNAME="admin"
PASSWORD="admin"

# Add keys from license file
KEY1=
KEY2=
KEY3=
KEY4=
KEY5=

#hosts=`cat ipmi_hosts`

for host in $hosts;do
 `curl -s --digest -u $USERNAME:$PASSWORD "http://$host/lkey.html?Lkey1=$KEY1&Lkey2=$KEY2&Lkey3=$KEY3&Lkey4=$KEY4&Lkey5=$KEY5&Submit=Apply" >>/dev/null`
 `curl -s --digest -u $USERNAME:$PASSWORD "http://$host/lkey.html?OKCANCEL=1&OK_BUTTON=Ok" >>/dev/null`
 `curl -s --digest -u $USERNAME:$PASSWORD "http://$host/lkey.html?OKCANCEL=1&OK_BUTTON=Ok" >>/dev/null`

done
