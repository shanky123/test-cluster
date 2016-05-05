#!/bin/bash

hostname=`hostname`

#if [ ! -f /home/runefr/hostid/hostid_$hostname ];then
/share/apps/xpress702/bin/xphostid >> /home/runefr/hostid/hostid_$hostname
#fi
