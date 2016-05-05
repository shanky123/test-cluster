#!/bin/bash
# Logs in to HP ILO-card and resets the system
# Change user and password to fit you system

expect << EOF

set timeout 20

spawn telnet ipmi-$1

expect "login: "
send "admin\r"

expect "Password: "
send "admin\r"

expect "*>"
send "reset system1\r"

expect "*>"
send "exit\r"

EOF
