# Linux Logrotate (로그 분산 관리)

---

## Logrotate

---

Logrotate는 Linux에서 로그를 저장하며 관리할 때, 로그 파일이 하나의 파일로 크기가 커지며 저장되는것을 분산시켜줄 때 사용한다.

한 파일에 로그가 지속적으로 쌓이게 도면 로그 확인이 필요한 경우 파일이 너무 방대해 확인이 어려워지고 디스크 용량 또한 낭비된다.

### Logrotate 실행 순서 & 구조

---

![images_gillog_post_d78caa68-b80f-495e-9222-b0bb998f13d0_image](https://user-images.githubusercontent.com/84123877/192410928-531de353-848a-44b2-831f-7bd20e1619db.png)

Logrotate은 위와 같은 순서로 실행하며, 구성하는 파일들은 아래와 같은 구조를 가진다.

- /usr/sbin/logrotate : Logrotate 데몬 프로그램
- /etc/logrotate.conf : Logrotate 데몬 설정 파일
- /etc/logrotate.d/ : Logrotate 프로세스 설정 파일
- /etc/cron.daily/logrotate : Logrotate 작업내역 로그

### Logrotate 설치

---

Logrotate는 Linux System에서 log관리를 위해 사용되는데, OS 설치시 기본적으로 설치되어 있다.

`rpm -qa | grep logrotate`

해당 명령어로 설치 유무를 확인 가능하다.

만약 설치되어 있지 않다면,

`yum -y install logrotate`

명령어로 설치 가능하다.

### Logrotate 옵션

---

~~

다른 옵션이 필요한 경우 `man logrotate` 명령어로 정보를 확인할 수 있다.

### logrotate.conf 설정

---

```bash
# rotate log files weekly
# log 회전 주기 yearly : 매년, monthly : 매월, weekly : 매주, daily : 매일
daily

# keep 4 weeks worth of backlogs
# log 파일 개수, 해당 개수가 넘어가면 logrotate의 주기에 따라 실행됨
rotate 7

# create new (empty) log files after rotating old ones
# 새로운 log 파일 생성 여부, create : log 파일 생성, empty : log 파일 생성 안함
create

# use date as a suffix of the rotated file
# 파일명 날짜 여부, logrotate 실행 후 log파일에 날짜를 부여
dateext

# uncomment this if you want your log files compressed
# log파일 압축 여부, 로그 파일 크기 조절 용도
# compress

# RPM packages drop log rotation information into this directory
# 개별 로그 process 설정 경로
include /etc/logrotate.d
```

logrotate.conf는 Logrotate 실행의 모든 설정을 담당한다.

### logrotate.d 설정

---

/etc/logrotate.d 에서는 Logrotate를 실행하는 개별 프로세스들에 대한 설정을 지정할 수 있다.

해당 경로에서 log 생성을 원하는 confug 파일을 작성해주면 된다.

```bash
/var/log/maillog /var/log/freshclam.log {
	// 일 단위로 실행
	daily
    	// 회전 주기 파일 개수
        rotate 7
        // log 파일 내용 없을 시 rotate 하지 않음
        notifempty
        // log 파일 없을 경우 error 메시지 출력 후 다음 실행
        missingok
        // 로그 파일 압축
        compress
        // 여러개 log 파일을 script로 공유하여 실행
        sharedscripts
        // logrotate 실행 후 스크립트 실행(스크립트 파일 경로가 와도 됨)
        postrotate
                /bin/kill -HUP `cat /var/run/syslogd.pid 2>/dev/null` 2> /dev/null || true
        endscript
}
```

config 파일을 작성한 후 명령어로 Logrotate을 실행시켜준다.

`/usr/sbin/logrotate -f /etc/logrotate.conf`

또한, 주기적으로 실행하기를 원한다면 crontab에 명령어를 등록하면 된다.

```
// 매주 일요일 자정 logrotate 실행
00 00 * * 7 /usr/sbin/logrotate -f /etc/logrotate.conf
```

아래는 실행 관련 Logrotate 명령어이다.

```
// logrotate 전체 실행
/usr/sbin/logrotate -d /etc/logrotate.conf

// 특정 logrotate process 실행
/usr/sbin/logrotate -d /etc/logrotate.d/apache

// logrotate 디버그 모드
/usr/sbin/logrotate -d /etc/logrotate.conf

// 실행 과정 화면 출력
/usr/sbin/logrotate -v /etc/logrotate.conf
```

### 실습

---

![Untitled](https://user-images.githubusercontent.com/84123877/192410924-9e165ddf-5b97-4be0-9492-65f23335f5fd.png)

logrotate.d 내에 기본적으로 설정되있는 boot.log를 확인했다.

내용으로는, 로그가 없을 시 에러메세지를 나타내며 매일 로테이션, 4개 이상으로는 생성이 안된다는 설정이다. compress로 log파일 압축을 진행한다.

![Untitled 1](https://user-images.githubusercontent.com/84123877/192410930-9a3c6e08-c0ed-4a61-83d3-f96684f5049f.png)


아직 시간이 지나지 않아 2개의 로그파일밖에 없지만, 매일 로테이션을 진행하며 최대 4개까지의 파일이 생성되니 4일마다 로그가 로테이션(변경)된다고 생각하면 된다.

---
