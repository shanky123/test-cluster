#!/bin/bash

users=`ls -1 /export/home/restore/`

for user in $users;do
	useradd $user;
done
