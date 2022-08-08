# 2.1 UMASK 설정 관리

---

![Untitled](https://user-images.githubusercontent.com/84123877/183345944-60130ba4-7164-4d3c-bd61-dffdd25f485c.png)

![Untitled 1](https://user-images.githubusercontent.com/84123877/183345938-478a4862-ffb2-4f01-b5e2-883bec75c8fd.png)

```bash
#! /bin/bash

TMP1=`umask`

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
```

## 결과

---

umask(파일,디렉터리 초기 접근권한 설정) 권한을 확인하는 스크립트이다.

값이 022 또는 027 이면 양호(/etc/profile)

### 권한 표준 일치

![Untitled 2](https://user-images.githubusercontent.com/84123877/183345941-026688c0-496a-4228-8363-ce64e4f65507.png)

### 권한 표준 불일치

![Untitled 3](https://user-images.githubusercontent.com/84123877/183345942-42752b27-cadd-41fa-9110-fbdda19fe710.png)

불일치의 경우 `umask (8진수3자리)` 명령으로 일회성 umask를 설정하여 테스트를 진행했다.

---
