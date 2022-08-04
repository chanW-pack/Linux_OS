# Linux default 계정 탐색 및 삭제

---

![2022-08-04 17 26 26](https://user-images.githubusercontent.com/84123877/182800791-f2fe0800-165e-4ca0-bfec-b8a05a51220d.png)

![Untitled](https://user-images.githubusercontent.com/84123877/182775993-fd5d3530-3fe3-42b5-801d-1e9dabbdc66b.png)

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

![Untitled 1](https://user-images.githubusercontent.com/84123877/182775986-071e8c31-597d-4589-8853-71e3767904be.png)

존재하는 default 계정을 자동 삭제하는 기능도 추가할 수 있다.

---
