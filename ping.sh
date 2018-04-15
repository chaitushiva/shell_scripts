#!/bin/bash
# Simple SHELL script for Linux and UNIX system monitoring with
# ping command
# -------------------------------------------------------------------------
# Copyright (c) 2006 nixCraft project 
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------
# This script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# -------------------------------------------------------------------------
# Setup email ID below
# See URL for more info:
# http://www.cyberciti.biz/tips/simple-linux-and-unix-system-monitoring-with-ping-command-and-scripts.html
# -------------------------------------------------------------------------

# add hostname in NAME array
NAME[0]="SERVER NAME ONE"
NAME[1]="SERVER NAME TWO"
NAME[2]="SERVER NAME ETC"

# add ip / hostname separated by white space
HOSTS="1.1.1.1 2.2.2 10.10.10.10"

# no ping request
COUNT=3

# email report when
SUBJECT="Ping failed"
EMAILID="employee1@mycompay.com, employee2@mycompay.com, boss@mycompay.com"

val=0

for myHost in $HOSTS
do
  archivo="$myHost.txt_$(date +%Y%m%d%H%M%S)"
  date > $archivo
  ping -c $COUNT $myHost >> $archivo

  count=$(cat $archivo | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')

  if [ $count -eq 0 ]; then
    # 100% failed
    echo "Host : $myHost  ${NAME[$val]}  is down (ping failed) at $(date)" | mail -s "$SUBJECT" $EMAILID
  fi
  a=$val
  val=$(expr $a + 1)
done
