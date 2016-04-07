#########################################################################
# File Name: cp.sh
# Author: dengguangjie
# mail: 563200085@qq.com
# Created Time: Wed 23 Mar 2016 10:03:35 AM CST
#########################################################################
#!/bin/bash
#export LD_LIBRARY_PATH=/usr/lib/gstreamer-0.10/:/usr/local/lib/
#mount 192.168.1.9:/home/dengguangjie/ /mnt -o nolock -t nfs
#cp /mnt/HDPlatform/BoxOut/FSL_SDK_A30/BoxPlayer/* /root/Box/BoxPlayer/ -a
pID=`cat /root/Box/SystemConfig/id|cut -d "-" -f 1`
#pID=`cat /root/id|cut -d "-" -f 1`
#echo "id = `cat /root/Box/SystemConfig/id`"
#echo id = "[$pID]"
logsrc=/root/Box/project/log/

PrintOK() {
	if [ $1 -eq 0 ];then
		echo -ne "\033[40;33;5m$pID  copy OK!\033[0m\n"
	else
		echo -ne "\033[40;31;5m>>>>>>>>>>>>
$pID copy Failed!Return: $?.
>>>>>>>>>>\033[0m\n"
	fi
}
CheckMount() {
	mount | grep "192.168.1.9:/home/dengguangjie/ on /mnt" > /dev/null
	if [ $? -eq 0 ] ;then
		echo -ne "\033[40;33;5m192.168.1.9:/home/dengguangjie/ on /mnt\033[0m\n"
	else
		mount 192.168.1.9:/home/dengguangjie/ /mnt -o nolock -t nfs
		if [ $? -eq 0 ] ;then
			echo -ne "\033[40;33;5mDo mount 192.168.1.9:/home/dengguangjie/ OK!\033[0m\n"
		else
			echo -ne "\033[40;31;5mD0 mount 192.168.1.9:/home/dengguangjie/ failed\033[0m\n"
			exit
		fi
	fi
}
if [ ! -n "$1" ];then
	echo "cp.sh export | mount "
    echo "cp.sh testimax | testam335 "
 	echo "cp.sh hard30 | hard60 | hardam335"
 	echo "cp.sh 3g30 | 3g60 | 3gam335"
	exit
fi
if [ $1 == "export" ]
	then
		export LD_LIBRARY_PATH=/usr/lib/gstreamer-0.10/:/usr/local/lib/
elif [ $1 == "mount" ]
	then
		mount 192.168.1.9:/home/dengguangjie/ /mnt -o nolock -t nfs
elif [ $1 == "id" ];then
	echo -e "`cat /root/Box/SystemConfig/id`"
elif [ $1 == "log" ] ;then
	echo "`cat /root/Box/SystemConfig/id`"
	cd $logsrc 
elif [ $1 == "test" ]
	then
		CheckMount
		if [[ "$pID" == "A30"* ]] || [[ "$pID" == "A60"* ]] ;then
			cp /mnt/TestButton/BoxOut/FSL_SDK_A60X_A30/BoxPlayer/* /root/Box/BoxPlayer/ -a
			PrintOK $?
		elif [[ "$pID" == "C"* ]] || [[ "$pID" == "D"* ]] ;then
			cp /mnt/TestButton/BoxOut/TI_SDK_CX0_DX0/BoxPlayer/* /root/Box/BoxPlayer/ -a
			PrintOK $?
		fi
elif [ $1 == "hard" ]
    then
		CheckMount
		if [[ "$pID" == "A30"* ]] ;then
            cp /mnt/HardwareDev/BoxOut/FSL_SDK_A30/BoxPlayer/* /root/Box/BoxPlayer/ -a
			PrintOK $?
		elif [[ "$pID" == "A60"* ]] ;then
			cp /mnt/HardwareDev/BoxOut/FSL_SDK_A60/BoxPlayer/* /root/Box/BoxPlayer/ -a
			PrintOK $?
        elif [[ "$pID" == "C"* ]] || [[ "$pID" == "D"* ]] ;then
			cp /mnt/HardwareDev/BoxOut/TI_SDK_CX0_DX0/BoxPlayer/* /root/Box/BoxPlayer/ -a
			PrintOK $?
		fi
elif [ $1 == "3g" ]
    then
		CheckMount
		if [[ "$pID" == "A30"* ]];then
        	cp /mnt/PacketFor3G/BoxOut/FSL_SDK_A30/BoxPlayer/* /root/Box/BoxPlayer/ -a
			PrintOK $?
		elif [[ "$pID" == "A60"* ]] ;then
			cp /mnt/PacketFor3G/BoxOut/FSL_SDK_A60/BoxPlayer/* /root/Box/BoxPlayer/ -a
			PrintOK $?
		elif [[ "$pID" == "C"* ]] || [[ "$pID" == "D"* ]] ;then
			cp /mnt/PacketFor3G/BoxOut/TI_SDK_CX0_DX0/BoxPlayer/* /root/Box/BoxPlayer/ -a
			PrintOK $?
        fi
else
		echo "cp.sh export | mount "
		echo "cp.sh test | hard | 3g "
fi
