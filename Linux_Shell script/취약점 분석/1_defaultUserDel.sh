#! /bin/bash

LIST_USER_NAME="
lp
mail
games
ftp
pipewire
pulse
gluster
setroubleshoot
saslauth
qemu
usbmuxd
gogotest
ec2-user
"

echo -e [ default 계정 탐색 중 ... ]
sleep 1s

for duser in $LIST_USER_NAME
do
	REPEAT_ACCOUNT=`cat /etc/passwd | grep $duser` 
	echo "[ "$duser" 검색]"
	sleep 1s
	if [ ! -z "$REPEAT_ACCOUNT" ] ; then
		echo -e "\033[32m" [ 양호] "\033[0m" 
		echo -e "\033[32m" "$duser"  계정이  존재하지 않습니다."\033[0m"
	else
		echo -e "\033[31m" [ 취약] "\033[0m" 
		echo -e "\033[31m" "$duser"  계정이  존재합니다."\033[0m"

	fi
done

sleep 0.5s
echo [ default 계정 탐색이 완료되었습니다. ]
