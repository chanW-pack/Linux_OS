#! /bin/bash

LIST_USER_NAME="
bin
daemon
adm
operator
games
nobody
systemd-network
ec2-user
"

#cat /etc/passwd |  awk -F: '{print $7}'

echo -e [ 로그인이 필요하지 않은 계정 제한 옵션  탐색 중 ... ]
sleep 1s

for nologin in $LIST_USER_NAME
do
	REPEAT_ACCOUNT=`cat /etc/passwd | grep -e "^$nologin" | awk -F: '{print $7}'`
	sleep 0.5s

	if [ "$REPEAT_ACCOUNT" == "/sbin/nologin" ] ; then
		echo -e "\033[32m" [ 양호] "\033[0m" 
		echo -e "\033[32m"  "$nologin" 계정 nologin 설정 정상 확인"\033[0m"
	else
		echo -e "\033[31m" [ 취약] "\033[0m" 
		echo -e "\033[31m" "$nologin"  계정이nologin 상태가 아닙니다. "\033[0m"
		sleep 0.5s
		echo -e "\033[31m" "상세 정보: "`cat /etc/passwd | grep -e "^$nologin" | awk -F: '{print $0}'`"\033[0m"
fi
done

sleep 0.5s
echo [ nologin shell 부여확인 탐색이 완료되었습니다. ]
