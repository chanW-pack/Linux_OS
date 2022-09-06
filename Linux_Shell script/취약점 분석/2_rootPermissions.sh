#! /bin/bash

TMP1=`cat /etc/passwd | grep -v 'root' | awk -F: '{if ($3=="0") print $0}'`

echo $TMP1

echo -e [ UID 탐색 중 ... ] 
sleep 1s

if [ -z "$TMP1"  ] ; then
	sleep 1s
	echo -e "\033[32m" [ 양호 ] "\033[0m"
	echo -e "\033[32m" root 제외 "0" 값의 UID가존재하지 않습니다."\033[0m"
else
	echo -e "\033[31m" [ 취약 ] "\033[0m"
	echo -e "\033[31m" root 제외 "0" 값의 UID가존재합니다."\033[0m"
	sleep 1s
        echo -e "\033[31m "UID = 0 값인계정 = "`awk -F ':' '{ if ($3=="0") print $1 }' /etc/passwd`\033[0m"
	sleep 1s
	echo -e "\033[31m "상세정보: "`awk -F ':' '{ if ($3=="0") print $0 }' /etc/passwd`\033[0m"
fi

sleep 1s
echo [ UID  탐색이 완료되었습니다. ]
