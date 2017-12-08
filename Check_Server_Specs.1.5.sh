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
                #Show the CPU info
                grep name /proc/cpuinfo | cut -d: -f2 | uniq -c
                
                #Show the Memory
                echo -ne "\e[00;33mMem: \e[00m"  
                free -h | awk "/^Mem/ {print \$2}"
                
                #Show the Disks in the Server
                echo -e "\e[00;92m======Drives======\e[00m"
                lsblk -d -o name,size,rota
                
                #Uncomment depending on OS
                cat /etc/*release | grep ID=
                #cat /etc/redhat-release
                #lsb_release -a
                
                echo -e "\e[00;96m======Network======\e[00m"
                #Uncomment if using SoftLayer's Network
                #ifconfig | grep -v "^ \|^$\|^lo";
                #ifconfig | grep "inet "
                #ethtool  | grep -i speed
                
                #Depending on the setup, uncomment to print Kernel
                #echo -e "\e[00;35m======Kernel======\e[00m"
                #dpkg --list | grep linux-image

        '

done
IFS=$ifsstore
