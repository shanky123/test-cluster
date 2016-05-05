#!/bin/bash
#
# Script to change ownership of folders in HOME-folder after a reinstall of frontend

users=`ls -1 /export/home/`

for user in $users;do
	chown $user.$user /export/home/$user -R
done
