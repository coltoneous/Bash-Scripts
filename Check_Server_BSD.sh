#!/bin/bash
#Check server script for BSD Operating system

ifsstore=$IFS
IFS=$'\n'
for i in `grep -v ^\# servers.lst`;do
        serviceid=$(echo $i | awk '{print $1}')
        serverip=$(echo $i | awk '{print $2}')
        serverpass=$(echo $i | awk '{print $3}')
        echo;echo
        sshpass -p $serverpass ssh -oStrictHostKeyChecking=no -l root $serverip '

                echo "=====CPU====="
                sysctl hw.model hw.machine hw.ncpu
                echo  "=====Mem====="
                sysctl hw.physmem
                grep memory /var/run/dmesg.boot
                echo "=====Drives====="
                geom disk list
                echo "=====Network====="
                /sbin/ifconfig | grep media
        '
done
IFS=$ifsstore
