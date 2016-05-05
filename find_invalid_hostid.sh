#!/bin/bash

dir="/home/runefr/hostid"
files=`ls -1 $dir`

for file in $files;do
	cat $dir/$file |grep "/invalid" -A 4|grep hostname|cut -f 2 -d ">"|cut -f 1 -d "<"

done

