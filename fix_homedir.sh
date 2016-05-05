#!/bin/bash

users=`ls -1 /export/home/`

for user in $users;do
	chown $user.$user /export/home/$user -R
#	rm -rf /export/home/$user/.ssh
done
