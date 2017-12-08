#!/bin/bash
#OS Detection

#Script Written By
#Colt Tomkinson Server Engineer
#Tyler Jensen Internal Operations
#Jason Barnes Server Administrator
#Copyright 100TB Brand The Hut Group Ltd.
#2017 The Hut.com Ltd. All rights reserved.

#==================================================
#Internal Use only! To use to install common proprietary Software for Hard Ware Raid
#cards offered by 100TB Servers.


OS=unknown
if [ -f /etc/redhat-release ]; then
    version=$( cat /etc/redhat-release | grep -oP "[0-9]+" | head -1 )
    OS=centos
		echo -e "\e[96m -----------------------\e[0m"
		echo -e "\e[96m |                     |\e[0m"
        echo -e "\e[96m |---CentOS Detected---|\e[0m"
		echo -e "\e[96m |                     |\e[0m"
		echo -e "\e[96m -----------------------\e[0m"
        sleep 1
		echo -e "\e[96m Installing: pciutils wget unzip \e[0m"
        yum -y install pciutils wget unzip 
elif [ -f /etc/fedora-release ]; then
    version=$( cat /etc/fedora-release | grep -oP "[0-9]+" | head -1 )
    OS=fedora
		echo -e "\e[96m -----------------------\e[0m"
		echo -e "\e[96m |                     |\e[0m"
        echo -e "\e[96m |---Fedora Detected---|\e[0m"
		echo -e "\e[96m |                     |\e[0m"
		echo -e "\e[96m -----------------------\e[0m"
        sleep 1
        echo -e "\e[96m Getting Required Packages\e[0m"
		sleep 1
		echo -e "\e[96m Installing: wget, pciutils, unzip \e[0m"
        yum -y install pciutils wget unzip
elif [ -n $(which lsb_release 2> /dev/null) ] && lsb_release -d | grep -q "Ubuntu"; then
    version=$( lsb_release -d | grep -oP "[0-9]+" | head -1 )
    OS=ubuntu
		echo -e "\e[95m -----------------------\e[0m"
        echo -e "\e[95m |                     |\e[0m"
		echo -e "\e[95m |   Ubuntu Detected   |\e[0m"
		echo -e "\e[95m |                     |\e[0m"
		echo -e "\e[95m -----------------------\e[0m"
        sleep 1
        echo -e "\e[95m Getting Required Packages\e[0m"
		sleep 1
		echo -e "\e[95m Installing: wget, pciutils, unzip \e[0m"
        apt-get update -y && apt-get install pciutils wget unzip -y
elif [ -n $(which lsb_release 2> /dev/null) ] && lsb_release -d | grep -q "Debian"; then
    version=$( lsb_release -d | grep -oP "[0-9]+" | head -1 )
    OS=debian
		echo -e "\e[36m -----------------------\e[0m"
        echo -e "\e[36m |                     |\e[0m"
		echo -e "\e[36m |   Debian Detected   |\e[0m"
		echo -e "\e[36m |                     |\e[0m"
		echo -e "\e[36m -----------------------\e[0m"
        sleep 1
        echo -e "\e[36m Getting Required Packages\e[0m"
		sleep 1
		echo -e "\e[36m Installing: wget, pciutils, unzip \e[0m"
        apt-get update -y && apt-get -y install wget unzip pciutils
elif [ -f /etc/gentoo-release ]; then 
		version=$( cat /etc/gentoo-release | grep -oP "[0-9]+" | head -1 )
		OS=gentoo
		echo -e "\e[32m -----------------------\e[0m"
		echo -e "\e[32m |                     |\e[0m"
		echo -e "\e[32m |   Gentoo Detected   |\e[0m"
		echo -e "\e[32m |                     |\e[0m"
		echo -e "\e[32m -----------------------\e[0m"
		echo -e "\e[32m Getting Required Packages\e[0m"
		sleep 1
		echo -e "\e[32m Installing: wget, pciutils, unzip \e[0m"
		emerge wget unzip pciutils
elif [ -f /etc/SuSE-release ]; then 
		version=$( cat /etc/SuSE-release | grep -oP "[0-9]+" | head -1 )
		OS=suse
		echo -e "\e[32m -----------------------\e[0m"
		echo -e "\e[32m |                     |\e[0m"
		echo -e "\e[32m |  OpenSuSE Detected  |\e[0m"
		echo -e "\e[32m |                     |\e[0m"
		echo -e "\e[32m -----------------------\e[0m"
		echo -e "\e[32m Getting Required Packages\e[0m"
		sleep 1
		echo -e "\e[32m Installing: wget, pciutils, unzip \e[0m"
		zypper install wget pciutils unzip 
fi
echo $OS
#3Ware Utility install
function threeware
{
if [[ "$OS" == "centos" ]] || [[ "$OS" == "fedora" ]]; then
        echo -e "\e[96m Adding the following CentOS Dependencies\e[0m"
        echo -e "\e[96m tw_cli\e[0m"
        sleep 1
        mkdir /root/twcli
        cd /root/twcli
        wget http://border.100tb.com/raid/tw_cli.zip
        unzip tw_cli.zip
        tar -zxvf tdmCliLnx.tgz
        mv tw_cli.x86_64 tw_cli
        chmod +x tw_cli
        ./tw_cli show
		echo -e "\e[92m Done!\e[0m"
elif [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "debian" ]]; then
        echo -e "\e[95m Creating Directory\e[0m"
		sleep 1
        mkdir /root/twcli
        cd /root/twcli
        wget http://border.100tb.com/raid/tw_cli.zip
        unzip tw_cli.zip
        tar -zxvf tdmCliLnx.tgz
        mv tw_cli.x86_64 tw_cli
        chmod +x tw_cli
        ./tw_cli show
		echo -e "\e[92m Done!\e[0m"
elif [[ "$OS" == "gentoo" ]] || [[ "$OS" == "suse" ]]; then
        echo -e "\e[32m Adding tw_cli for 3Ware\e[0m"
        echo -e "\e[32m Loading \e[0m"
		sleep 1
        mkdir /root/twcli
        cd /root/twcli
        wget http://border.100tb.com/raid/tw_cli.zip
        unzip tw_cli.zip
        tar -zxvf tdmCliLnx.tgz
        mv tw_cli.x86_64 tw_cli
        chmod +x tw_cli
        ./tw_cli show
		echo -e "\e[92m Done!\e[0m"		
fi
}
#MegaRAID LSI Utility install
function MegaRAID
{
if [[ "$OS" == "centos" ]] || [[ "$OS" == "suse" ]] || [[ "$OS" == "fedora" ]]; then
        echo -e "\e[96m Creating Directory \e[0m"
		sleep 1
		mkdir /root/megaraid
        cd /root/megaraid
        wget https://docs.broadcom.com/docs-and-downloads/raid-controllers/raid-controllers-common-files/8-07-10_MegaCLI_Linux.zip
        unzip 8-07-10_MegaCLI_Linux.zip
        cd 8.07.10_MegaCLI_Linux/Linux\ MegaCLI\ 8.07.10
        rpm -ivh Lib_Utils-1.00-09.noarch.rpm
        rpm -ivh MegaCli-8.07.10-1.noarch.rpm
        echo -e "\e[96m Testing Raid Utility\e[0m"
        /opt/MegaRAID/MegaCli/MegaCli64 -AdpAllinfo -aALL
		echo -e "\e[92m Done!\e[0m"
elif [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "debian" ]]; then
        echo -e "\e[95m Installing MegaCLI\e[0m"
        echo -e "\e[95m Adding rpm2cpio \e[0m"
        apt-get update -y && apt-get install rpm2cpio wget unzip -y
		mkdir /root/megaraid
        cd /root/megaraid
        wget https://docs.broadcom.com/docs-and-downloads/raid-controllers/raid-controllers-common-files/8-07-10_MegaCLI_Linux.zip
        unzip 8-07-10_MegaCLI_Linux.zip
        cd 8.07.10_MegaCLI_Linux/Linux\ MegaCLI\ 8.07.10/
        rpm2cpio MegaCli-8.07.10-1.noarch.rpm | cpio -idmv
        mv opt/MegaRAID/MegaCli/MegaCli64 /usr/sbin/megacli
        cd /root/
        rm -rf 8.07.10_MegaCLI_Linux/ 8-07-10_MegaCLI_Linux.zip
        echo -e "\e[56m Testing Raid Utility\e[0m"
        megacli -AdpAllinfo -aALL 
		echo -e "\e[92m Done!\e[0m"
fi
}
#Adaptec Utility install
function Adaptec
{
if [[ "$OS" == "centos" ]] || [[ "$OS" == "fedora" ]]; then
    echo -e "\e[96m Adding the following CentOS Dependencies\e[0m"
    echo -e "\e[96m Wget , unzip, MegaCLI\e[0m"
    yum install compat-libstdc++-33** -y
elif [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "debian" ]]; then
    echo -e "\e[95m Adding the following Ubuntu / Debian Dependencies\e[0m"
    echo -e "\e[95m Wget , unzip, rpm2cpio, MegaCLI\e[0m"
    apt-get update -y && apt-get install wget unzip rpm2cpio -y
    wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-3.3/libstdc++5_3.3.6-25ubuntu1_amd64.deb && dpkg -i libstdc++5_3.3.6-25ubuntu1_amd64.deb
	
elif [[ "$OS" == "gentoo" ]]; then
    echo -e "\e[32m Checking for libstdc++\e[0m"
    sleep 2
    echo -e "\e[32m Doing stuff for Gentoo\e[0m"
    #Checking to see what Gentoo needs here with libstdc++
	#this looks like it:
	emerge libstdc++
elif [[ "$OS" == "suse" ]]; then
    echo -e "\e[32m OpenSuSE\e[0m"
fi
echo -e "\e[96m Starting install\e[0m"
sleep 1
#Create StorMan Dir
echo -e "\e[96m Creating dir for StorMan\e[0m"
mkdir /usr/StorMan
cd /usr/StorMan
#Install actual Utility
echo -e "\e[96m Grabbing the files\e[0m"
sleep 1
wget http://border.100tb.com/raid/arcconf_v1_5_20942.zip
unzip arcconf_v1_5_20942.zip
#Create Link and Set Permissions
echo -e "\e[96m Creating Symlink\e[0m"
cd linux_x64/
cp cmdline/arcconf /usr/StorMan/
sleep 1
echo -e "\e[95m Setting Permissions\e[0m"
sleep 1
chmod 755 /usr/StorMan/arcconf
echo -e "\e[92m Testing Raid Utility\e[0m"
sleep 1
/usr/StorMan/arcconf getconfig 1
echo -e "\e[92m Done!\e[0m"
}
#Raid Card Detection
CARDTYPE=$(lspci | grep -oi "LSI\|Adaptec\|3ware" 2>/dev/null| awk '{print tolower($0)}')
if [[ "$CARDTYPE" == "lsi" ]]; then
        echo -e "\e[93m LSI Detected, Installing MegaRaid Utility\e[0m"
        MegaRAID
elif [[ "$CARDTYPE" == "adaptec" ]]; then
        echo -e "\e[92m Adaptec Detected, Installing StorMan\e[0m"
        Adaptec
elif [[ "$CARDTYPE" == "3ware" ]]; then
        echo -e "\e[96m 3Ware Detected, installing tw_cli\e[0m"
        threeware
else
        echo -e "\e[91m HW raid Card not detected or Supported by script\e[0m"
fi
