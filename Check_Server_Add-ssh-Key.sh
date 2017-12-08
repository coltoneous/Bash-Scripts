ifsstore=$IFS
IFS=$'\n'
for i in `grep -v ^\# servers.lst`;do
        serviceid=$(echo $i | awk '{print $1}')
        serverip=$(echo $i | awk '{print $2}')
        serverpass=$(echo $i | awk '{print $3}')
        echo;echo
        echo -e "\e[00;44m$serviceid\e[00m"
        sshpass -p $serverpass ssh -oStrictHostKeyChecking=no -l root $serverip '
                echo -en "\e[00;94mCPU:\e[00m"
                grep name /proc/cpuinfo | cut -d: -f2 | uniq -c
                echo -ne "\e[00;33mMem: \e[00m"
                free -m | awk "/^Mem/ {print \$2}"
                echo -e "\e[00;92m======Drives======\e[00m"
                lsblk -d -o name,size,rota
                #cat /etc/*release | grep ID=
                lsb_release -a
                echo -e "\e[00;96m======Network======\e[00m"
                #ifconfig | grep -v "^ \|^$\|^lo";
                #ifconfig | grep "inet "
                ethtool bond1 | grep -i speed
                #echo -e "\e[00;35m======Kernel======\e[00m"
                #dpkg --list | grep linux-image
                mkdir ~root/.ssh
                chmod 700 ~root/.ssh


        '

done
#IFS=$ifsstore
for i in `grep -v ^\# servers.lst`;do
        serviceid=$(echo $i | awk '{print $1}')
        serverip=$(echo $i | awk '{print $2}')
        serverpass=$(echo $i | awk '{print $3}')
        echo;echo
        echo -e "\e[00;44m$serviceid\e[00m"
        echo -e "\e[00;93m======Adding Key(s)======\e[00m"
        rsync --rsh="/usr/bin/sshpass -p $serverpass ssh -o StrictHostKeyChecking=no -l root" authorized_keys root@$serverip:~root/.ssh/
        sshpass -p $serverpass ssh -oStrictHostKeyChecking=no -l root $serverip '
                chmod 600 ~root/.ssh/authorized_keys
                echo -e "\e[00;92m======Key Added======\e[00m"
        '
done

IFS=$ifsstore
