#!/bin/ksh
( echo open power-$1
  sleep 1
  echo admin
  sleep 1
  echo admin
  sleep 1
  echo start system1 
  sleep 2
  ) | telnet
