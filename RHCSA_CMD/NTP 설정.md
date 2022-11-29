# NTP 설정

---

### NTP 설정

`utility.net1.example.com`을 통해 시간이 동기화 되도록 ntp 클라이언트를 구성한다.

참고로, `utility.net1.example.com` 은 바뀌기 때문에, 문제에 지정되어 있는 호스트로 바꿔서 작업한다.

```bash
# chrony 설치
[root@localhost contrib]# yum -y install chrony

Upgraded:
  chrony-4.1-3.el9.rocky.0.1.x86_64                                               

Complete!

# /etc/chrony.conf 파일을 수정하여 ntp 클라이언트 구성
[root@localhost contrib]# vi /etc/chrony.conf 
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (https://www.pool.ntp.org/join.html).
# pool 2.rhel.pool.ntp.org iburst  << 기존 ntp (주석처리함)
server utility.net1.exapmle.com iburst  #새로 추가
wq!

# chronyd 데몬 시작 및 부팅시 활성화 설정
[root@localhost contrib]# systemctl enable --now chronyd
또는 
[root@localhost contrib]# systemctl start chronyd
[root@localhost contrib]# systemctl enable chronyd
(두 설정 동일함)

# NTP 서버와의 싱크 활성화
[root@localhost contrib]# timedatectl set-ntp false
[root@localhost contrib]# timedatectl set-ntp true
또는 
[root@localhost contrib]# timedatectl set-ntp yes

# NTP 서버 싱크 활성화 확인
[root@localhost contrib]# timedatectl status
               Local time: Wed 2022-11-23 14:57:47 KST
           Universal time: Wed 2022-11-23 05:57:47 UTC
                 RTC time: Wed 2022-11-23 05:57:47
                Time zone: Asia/Seoul (KST, +0900)
System clock synchronized: no
              NTP service: active
          RTC in local TZ: no

# 정상 연결 여부 확인
[root@localhost contrib]# chronyc sources
MS Name/IP address         Stratum Poll Reach LastRx Last sample               
===============================================================================
^? lb-182-207.above.com          0   7     0     -     +0ns[   +0ns] +/-    0ns

```

---
