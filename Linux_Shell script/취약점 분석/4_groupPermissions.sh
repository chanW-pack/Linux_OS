#! /bin/bash

TMP1=`sudo ls -la /etc | grep -v 'group-' | grep -w 'group' | awk -F " " '{print $1}'`
#echo $TMP1

echo -e [ /etc/group 파일 권한 설정 확인 중 ... ]
sleep 1s

if [ "$TMP1" == "-rw-r--r--" ] ; then
	sleep 1s
	echo -e "\033[32m" [ 양호] "\033[0m"
	echo -e "\033[32m" /etc/group 파일 권한 이상이 없습니다. "\033[0m"
	echo -e "\033[32m" 권한이644로 양호합니다. "\033[0m"
else
	sleep 1s
	echo -e "\033[31m" [ 취약] "\033[0m"
	echo -e "\033[31m" /etc/group 파일 권한이 보안 표준과 일치하지 않습니다. "\033[0m"
	sleep 1s
	echo -e "\033[31m `sudo ls -la /etc | grep -v 'group-' | grep -w 'group' `\033[0m"
	sleep 1s
	echo -e "\033[31m" /etc/group 파일 권한644 로 변경이 필요합니다.  "\033[0m"
	
fi

sleep 1s
echo [ /etc/group 권한 탐색이 완료되었습니다. ]
