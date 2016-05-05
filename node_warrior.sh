#!/bin/bash

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
