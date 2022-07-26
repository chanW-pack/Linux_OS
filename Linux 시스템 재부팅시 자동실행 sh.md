# Linux 시스템 재부팅시 자동실행 sh

---

리눅스를 사용하다 보면 서버가 부팅할때 자동으로 실행되어야 할 명령이나 스크립트가 생기기 마련이다.
(서버 운영중 정전 등의 이유로 재부팅된다거나 할때 서비스들을 자동으로 살려야하기 때문에..)

그리하여 이번에는 시스템이 재부팅될때 자동적으로 sh을 실행시켜주는 기능 2가지를 실습해보겠다.

각 ec2 2대를 준비하여 진행하였다.

## **local.service 생성 방법**

---

![Untitled](Linux%20%E1%84%89%E1%85%B5%E1%84%89%E1%85%B3%E1%84%90%E1%85%A6%E1%86%B7%20%E1%84%8C%E1%85%A2%E1%84%87%E1%85%AE%E1%84%90%E1%85%B5%E1%86%BC%E1%84%89%E1%85%B5%20%E1%84%8C%E1%85%A1%E1%84%83%E1%85%A9%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF%E1%84%92%E1%85%A2%E1%86%BC%20sh%2031b0ac2c2f0644cd9e03a6331836beca/Untitled.png)

![Untitled](Linux%20%E1%84%89%E1%85%B5%E1%84%89%E1%85%B3%E1%84%90%E1%85%A6%E1%86%B7%20%E1%84%8C%E1%85%A2%E1%84%87%E1%85%AE%E1%84%90%E1%85%B5%E1%86%BC%E1%84%89%E1%85%B5%20%E1%84%8C%E1%85%A1%E1%84%83%E1%85%A9%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF%E1%84%92%E1%85%A2%E1%86%BC%20sh%2031b0ac2c2f0644cd9e03a6331836beca/Untitled%201.png)

```bash
vi /etc/systemd/system/rc-local.service  # 생성

[Unit]                                   # 내용 추가
Description=Run rc.local
#After=suspend.target
#After=hibernate.target
#After=hybrid-sleep.target

[Service]
ExecStart=/etc/rc.local start
```

`/etc/systemd/system/rc-local.service` 파일을 생성하고 내용을 추가한다.

이후 `/etc/rc.local` 파일을 생성하고 실행 시 발동하고 싶은 명령어나 내용을 작성한다.

![Untitled](Linux%20%E1%84%89%E1%85%B5%E1%84%89%E1%85%B3%E1%84%90%E1%85%A6%E1%86%B7%20%E1%84%8C%E1%85%A2%E1%84%87%E1%85%AE%E1%84%90%E1%85%B5%E1%86%BC%E1%84%89%E1%85%B5%20%E1%84%8C%E1%85%A1%E1%84%83%E1%85%A9%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF%E1%84%92%E1%85%A2%E1%86%BC%20sh%2031b0ac2c2f0644cd9e03a6331836beca/Untitled%202.png)

> 텍스트 파일을 생성하는 sh이다. 정상 작동을 한다면 재부팅시 test.txt 파일이 생성될것이다.
> 

이후 다음 명령어들을 순차적으로 진행한다.

```bash
sudo chmod +x /etc/rc.local # 권한 주기

sudo systemctl enable rc-local # 활성화

sudo systemctl start rc-local.service # 서비스 실행

sudo systemctl status rc-local.service # 서비스 상태 확인
```

![Untitled](Linux%20%E1%84%89%E1%85%B5%E1%84%89%E1%85%B3%E1%84%90%E1%85%A6%E1%86%B7%20%E1%84%8C%E1%85%A2%E1%84%87%E1%85%AE%E1%84%90%E1%85%B5%E1%86%BC%E1%84%89%E1%85%B5%20%E1%84%8C%E1%85%A1%E1%84%83%E1%85%A9%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF%E1%84%92%E1%85%A2%E1%86%BC%20sh%2031b0ac2c2f0644cd9e03a6331836beca/Untitled%203.png)

> 서비스가 정상작동중이다. 이제 재부팅을 진행해보겠다.
> 

![Untitled](Linux%20%E1%84%89%E1%85%B5%E1%84%89%E1%85%B3%E1%84%90%E1%85%A6%E1%86%B7%20%E1%84%8C%E1%85%A2%E1%84%87%E1%85%AE%E1%84%90%E1%85%B5%E1%86%BC%E1%84%89%E1%85%B5%20%E1%84%8C%E1%85%A1%E1%84%83%E1%85%A9%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF%E1%84%92%E1%85%A2%E1%86%BC%20sh%2031b0ac2c2f0644cd9e03a6331836beca/Untitled%204.png)

> 재부팅 전
> 

![Untitled](Linux%20%E1%84%89%E1%85%B5%E1%84%89%E1%85%B3%E1%84%90%E1%85%A6%E1%86%B7%20%E1%84%8C%E1%85%A2%E1%84%87%E1%85%AE%E1%84%90%E1%85%B5%E1%86%BC%E1%84%89%E1%85%B5%20%E1%84%8C%E1%85%A1%E1%84%83%E1%85%A9%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF%E1%84%92%E1%85%A2%E1%86%BC%20sh%2031b0ac2c2f0644cd9e03a6331836beca/Untitled%205.png)

> 재부팅 후 파일 생성 sh이 실행되어 txt가 정상적으로 생성된것을 확인할 수 있다. 굳~
> 

---

## /init.d 자동 실행 등록 (ubuntu,debian)

---

![Untitled](Linux%20%E1%84%89%E1%85%B5%E1%84%89%E1%85%B3%E1%84%90%E1%85%A6%E1%86%B7%20%E1%84%8C%E1%85%A2%E1%84%87%E1%85%AE%E1%84%90%E1%85%B5%E1%86%BC%E1%84%89%E1%85%B5%20%E1%84%8C%E1%85%A1%E1%84%83%E1%85%A9%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF%E1%84%92%E1%85%A2%E1%86%BC%20sh%2031b0ac2c2f0644cd9e03a6331836beca/Untitled%206.png)

> 서비스를 실행 할 스크립트를 /etc/init.d 에 생성한다.
> 

자동 실행 등록을 하면 해당 스크립트가 실행되어 서비스를 띄우게 된다.

```bash
chmod 777 /etc/init.d/[실행 스크립트이름] # 권한 부여

# ex : chmod 777 /etc/init.d/auto_run.sh
```

해당 스크립트에 권한을 부여한다.

```bash
update-rc.d [실행 스크립트 이름] defaults # 서비스 등록

# ex : update-rc.d auto_run.sh defaults
```

```bash
ls /etc/rc*/*[스크립트 파일] # 등록 확인
# ex : /etc/rc*/*auto_run.sh
```

… 근데 작동이 안된다.

22.04 버전에서 서비스 등록까지는 진행되는데 reboot시 sh 작동이 안되는거같다.

버전문제인가 싶어 20.04 버전으로 다시 시도해봐도 동일하다.

~~(EC2 인스턴스에서 자체적으로 스크립트 자동 실행 기능이 있어서(콘솔) ec2 한정으로 안되는건가 싶기도 하다.)~~
아니였다.. 아래 항목에 정확한 이유를 설명.

---

### 해결완료되었다. sh 파일 내에 내용을 더 추가해야 하는듯 하다.

![Untitled](Linux%20%E1%84%89%E1%85%B5%E1%84%89%E1%85%B3%E1%84%90%E1%85%A6%E1%86%B7%20%E1%84%8C%E1%85%A2%E1%84%87%E1%85%AE%E1%84%90%E1%85%B5%E1%86%BC%E1%84%89%E1%85%B5%20%E1%84%8C%E1%85%A1%E1%84%83%E1%85%A9%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF%E1%84%92%E1%85%A2%E1%86%BC%20sh%2031b0ac2c2f0644cd9e03a6331836beca/Untitled%207.png)

**위는 이미 존재하는 ssh의 자동 설정 파일이다.**

**위 BEGIN INIT INFO 를 본인의 sh에 추가하여 진행하니 정상적으로 작동되었다.**

 

### 실행파일

```bash
/sbin/init : init가 실행해야 할 모든 일이 명시된 파일
/etc/init.d/rc : 각 실행 단계 스크립트
/etc/init.d/rcS : init에서 처음으로 실행하는 스크립트
```

### 디렉터리

```bash
/etc/init.d : 각 실행 단계에서 실행되는 실제 스크립트가 저장
/etc/rcS.d : rcS 스크립트에 의해 실행되어질 명령 목록
/etc/rc0.d : 0 번 단계에서 실행되어질 명령 목록
/etc/rc1.d : 1 번 단계에서 실행되어질 명령 목록
/etc/rc2.d : 2 번 단계에서 실행되어질 명령 목록
/etc/rc3.d : 3 번 단계에서 실행되어질 명령 목록
/etc/rc4.d : 4 번 단계에서 실행되어질 명령 목록
/etc/rc5.d : 5 번 단계에서 실행되어질 명령 목록
/etc/rc6.d : 6 번 단계에서 실행되어질 명령 목
```

스크립트가 /etc/init.d에 위치하고 있어야 하며, 그 스크립트를 실행 단계 디렉터리에 심볼릭 링크로 걸어주어야 한다.

이러한 링크를 걸어주는 작업을 update-rc.d가 수행한다.

즉, 부팅 시 자동 시작을 비활성화하기 위해서는 /etc/rc?.d/에 걸려있는 심볼릭 링크를 제거하면 되며, 그 명령어는 다음과 같다.

```bash
update-rc.d -f <SERVICE_NAME> remove
# -f : /etc/init.d 내에 실제 링크되어 있는 파일 삭제
# -n : 실행 과정 출력

# 예시
update-rc.d -f apache2 remove
```

---