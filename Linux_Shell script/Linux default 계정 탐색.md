# Linux default 계정 탐색

---

![Untitled](Linux%20default%20%E1%84%80%E1%85%A8%E1%84%8C%E1%85%A5%E1%86%BC%20%E1%84%90%E1%85%A1%E1%86%B7%E1%84%89%E1%85%A2%E1%86%A8%2049e5bd831b94410cae113e921fa7b769/Untitled.png)

```bash
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
                echo -e "\033[32m" [ 양호 ] "\033[0m"
                echo -e "\033[32m" "$duser"  계정이  존재하지 않습니다."\033[0m"
        else
                echo -e "\033[31m" [ 취약 ] "\033[0m"
                echo -e "\033[31m" "$duser"  계정이  존재합니다."\033[0m"

        fi
done

sleep 0.5s
echo [ default 계정 탐색이 완료되었습니다. ]
```

## 결과

---

![Untitled](Linux%20default%20%E1%84%80%E1%85%A8%E1%84%8C%E1%85%A5%E1%86%BC%20%E1%84%90%E1%85%A1%E1%86%B7%E1%84%89%E1%85%A2%E1%86%A8%2049e5bd831b94410cae113e921fa7b769/Untitled%201.png)

존재하는 default 계정을 자동 삭제하는 기능도 추가할 수 있다.

---