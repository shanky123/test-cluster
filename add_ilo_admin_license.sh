#!/bin/bash

#hosts=`cat ipmi_hosts`

hosts="ipmi-1-24 ipmi-1-25"

for host in $hosts;do
 `curl -s --digest -u admin:admin "http://$host/lkey.html?Lkey1=3545L&Lkey2=M9PMZ&Lkey3=L2PNW&Lkey4=GHQR6&Lkey5=ST72N&Submit=Apply" >>/dev/null`
 `curl -s --digest -u admin:admin "http://$host/lkey.html?OKCANCEL=1&OK_BUTTON=Ok" >>/dev/null`
 `curl -s --digest -u admin:admin "http://$host/lkey.html?OKCANCEL=1&OK_BUTTON=Ok" >>/dev/null`

done
