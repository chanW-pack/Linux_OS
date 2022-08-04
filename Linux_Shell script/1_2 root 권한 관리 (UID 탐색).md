# 1.2 root 권한 관리 (UID 탐색)

---

![Untitled](https://user-images.githubusercontent.com/84123877/182795413-d36f3139-935a-40bc-8ca4-597d505c3968.png)

```bash
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
```

## 결과

---

(* UID 0을 생성할 수 없어, UID 222 계정을 찾도록 변경했다.)

### 존재

![Untitled 1](https://user-images.githubusercontent.com/84123877/182795405-9bc4fbdb-77b6-4704-9088-959b0fbe5d91.png)

### 미존재

![Untitled 2](https://user-images.githubusercontent.com/84123877/182795410-cb9f2792-e20c-440e-b5f6-cdd0927be80d.png)

root 계정만 UID 0 을 가지도록 UID 0 인 계정들을 찾고 나타내는 기능이다.

---
