#! /bin/bash

TMP1=`umask`

#꼭root 계정에서 실행해야 한다. 

echo -e [UMASK 설정 점검 중 ...]
sleep 1s

if [ "$TMP1" == "0022" ] || [ r"$TMP1" == "0027" ] ; then
	echo -e "\033[32m" [ 양호] "\033[0m"
        echo -e "\033[32m" UMASK  설정 정상 확인"\033[0m"	
	sleep 0.3s
	echo -e "\033[34m" 현재 UMASK 값:  $TMP1"\033[0m"
else
	echo -e "\033[31m" [ 취약] "\033[0m"
	echo -e "\033[31m" UMASK 값이 0022 또는 0027 상태가 아닙니다. "\033[0m"
	sleep 0.3s
	echo -e "\033[31m" 현재 UMASK 값:  $TMP1"\033[0m"
fi

sleep 0.5s
echo [ UMASK 상태 확인이 완료되었습니다. ]

