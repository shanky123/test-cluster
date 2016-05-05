#!/bin/ksh
( echo open ipmi-$1
  sleep 1
  echo admin
  sleep 1
  echo admin
  sleep 1
  echo reset system1 
  sleep 2
  ) | telnet
