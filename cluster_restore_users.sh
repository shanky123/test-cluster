#!/bin/bash
#
# Script to restore users after reinstall of frontend

users=`ls -1 /export/backup/restore/`

for user in $users;do
	useradd $user;
done
