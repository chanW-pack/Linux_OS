# 1.4 사용자 shell 점검 </br>
### (로그인이 필요하지 않은 계정에 /bin/nologin 쉘 부여 확인)

---

![Untitled](https://user-images.githubusercontent.com/84123877/183327417-a0131de3-aa60-453d-89a5-d4678a8e5073.png)

![Untitled 1](https://user-images.githubusercontent.com/84123877/183327414-b2ab955d-34f2-4bc3-ab39-073e4e4ee1c0.png)

```bash
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
```

## 결과

---

![Untitled 2](https://user-images.githubusercontent.com/84123877/183327416-15228a4c-eaa1-4e32-9c55-1488b564203b.png)

`LIST_USER_NAME` 리스트에 nologin 계정을 지정하고 /etc/passwd 정보를 확인하여 nologin 설정이 되어 있는지 확인하는 스크립트이다.

---
