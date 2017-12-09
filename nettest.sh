#!/bin/bash
# Use this to run in the background on a 
# machine that has reports of intermittent 
# network loss. Will write to a file called "netdown.txt"
# if network goes down, and will write the date/ amount of time
# it is down. 
# vi nettest.sh (paste) chmod 777 ./nettest &

while true
do
ping 8.8.8.8 -c 1
RESULT=$?
ping 8.8.4.4 -c 1
RESULT+=$?
ping 208.67.222.222 -c 1
RESULT+=$?
ping 208.67.220.220 -c 1
RESULT+=$?
echo $RESULT
RESULT4=$RESULT
sleep 1
if (($RESULT4 != 0)); then
date >> netdown.txt
fi
done
