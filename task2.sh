#!/bin/bash

echo "
------------------------ System Report ---------------------------";
time=`date|awk '{print $4}'`;

host=`hostname`;

uptime=`uptime -p`;
uptime=`echo ${uptime:2}`

users=`who|wc -l`;

DATE=`date +%d/%m/%Y`

free=`free -m| grep Mem | awk '{print $7}'`
total=`free -m| grep Mem | awk '{print $2}'`
usage=`echo "100-$free*100/$total" | bc `

ld1=`top -bn1| grep -m1 ""| awk '{print $10}'`
ld1=${ld1::-1}
ld2=`top -bn1| grep -m1 ""| awk '{print $11}'`
ld2=${ld2::-1}
ld3=`top -bn1| grep -m1 ""| awk '{print $12}'`
ld3=${ld3::-1}
load_avg=`echo "scale=2;($ld1+$ld2+$ld3)/3"|bc`

echo "Date: $DATE      Time: $time       Host Name: $host
------------------------------------------------------------------
Uptime: $uptime
Current Users: $users
Memory Usage: $usage%
CPU Load: $load_avg
------------------------------------------------------------------
";
