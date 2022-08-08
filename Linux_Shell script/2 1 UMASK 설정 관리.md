# 2.1 UMASK 설정 관리

---

![Untitled](2%201%20UMASK%20%E1%84%89%E1%85%A5%E1%86%AF%E1%84%8C%E1%85%A5%E1%86%BC%20%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5%20fcbc8ed3e3594ba59137ce21e2e6a3be/Untitled.png)

![Untitled](2%201%20UMASK%20%E1%84%89%E1%85%A5%E1%86%AF%E1%84%8C%E1%85%A5%E1%86%BC%20%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5%20fcbc8ed3e3594ba59137ce21e2e6a3be/Untitled%201.png)

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

![Untitled](2%201%20UMASK%20%E1%84%89%E1%85%A5%E1%86%AF%E1%84%8C%E1%85%A5%E1%86%BC%20%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5%20fcbc8ed3e3594ba59137ce21e2e6a3be/Untitled%202.png)

### 권한 표준 불일치

![Untitled](2%201%20UMASK%20%E1%84%89%E1%85%A5%E1%86%AF%E1%84%8C%E1%85%A5%E1%86%BC%20%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5%20fcbc8ed3e3594ba59137ce21e2e6a3be/Untitled%203.png)

불일치의 경우 `umask (8진수3자리)` 명령으로 일회성 umask를 설정하여 테스트를 진행했다.

---