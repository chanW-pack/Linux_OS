# 로그관리 (/etc/syslog.conf)

---

### /etc/syslog.conf 파일의 이해와 활용

---

- /etc/syslog.conf 파일의 각 행의 형식(포맷)
= `서비스 종류.우선순위;서비스 종류.우선순위  /로그파일 위치`
ex. `authpriv.*    /var/log/secure`

- 각 행의 의미
= 서비스 종류(데몬)에 대하여 우선순위의 상황이 발생하면 로그파일 위치의 파일에 그 내용을 기록한다.
</br> </br>
### 규칙
- 서비스 종류는 facility, 우선순위는 priority, 로그파일위치는 logfile-location을 각각 의미한다.
- 서비스 종류와 우선순위는 .(점)으로 구분한다.
- “서비스종류.우선순위” 그리고 “서비스종류.우선순위” 사이에는 ;(세미콜론)으로 구분한다.
- 서비스종류에는 mail, cron, kern, uucp 등과 같은 해당 서비스의 종류를 의미한다.
- 우선순위에는 지정된 서비스의 종류의 상황정도를 의미한다.
- 로그파일위치는 서비스 종류와 우선순위에 의해서 발생하는 로그가 기록될 파일의 위치를 의미한다. 
- 서비스종류 자리에 *이 설정되면 모든 서비스를 의미한다.
- 우선순위 자리에 *이 설정되면 모든 우선순위(상황)을 의미한다.
- 로그파일위치 자리에 *가 설정되면 모든 로그파일을 의미한다.

### 서비스 종류(facility, 데몬 종류)

---

해당 로그파일에 기록할 서비스의 종류, 즉 데몬 종류를 의미한다.

| facility | command |
| -------- | :------: | 
| auth | 로그인과 같이 사용자 인증에 관한 메세지 |
| uucp | uucp에 의한 시스템에 관한 메세지 |
| mail | sendmail, pop, qmail 등과 같은 메일 관련 메세지 |
| authpriv | 보안 및 승인에 관한 메세지 |
| cron | crond 데몬과 atd 데몬에 의해 발생되는 메세지 |
| deamon | telnet, ftp 등과 같은 데몬에 의한 메세지 |
| kern | kernel에 의한 메세지로써, 커널메세지 라고 함 |
| ipr | 프린터데몬인 ipd에 의해 발생되는 메세지 |
| news | innd 등과 같은 뉴스시스템에 의해 발생되는 메세지 |
| * | 모든 서비스에 발생되는 메세지 |

### 우선순위(priority, 상황 정도)

---

지정한 서비스의 종류에 대한 우선순위(상황정도) 를 의미한다.

| priority | command |
| -------- | :------: | 
| 9 *  | 모든상황의 메시지(all) |
| 8 debug | debugging에 관한 메시지(가장 낮은 단계) |
| 7 info | 단순한 프로그램에 대한 정보 메시지(information) |
| 6 notice | 에러가 아닌 알림에 대한 메시지 |
| 5 warn | 주의를 요하는 메시지(warning) |
| 4 err | 에러로 인한 메시지(error) |
| 3 crit | 급한상황은 아니지만 치명적인 시스템 문제 발생 메시지(critical) |
| 2 alert | 즉각적인 조치를 해야하는 메시지 |
| 1 emerg | 매우 위험한 상황의 메시지(가장 높은 단계, emergency) |
| 0 none | 해당사항없음. 메시지없음.(기록될 내용이 없음) |

!! 주의사항

각 우선순위들은 포함관계를 나타낸다. (매우 중요)

ex) 9단계인 *은 모든 메세지를 의미함(1부터 9까지의 모든 상황을 포함)
ex) 8단계인 debug는 1부터 8까지의 상황을 모두 포함

### syslog.conf 기본 내용

---

```json
# Log all kernel messages to the console.
# Logging much else clutters up the screen.
#kern.*                                   /dev/console
# Log anything (except mail) of level info or higher.
# Don't log private authentication messages!
*.info;mail.none;authpriv.none;cron.none                /var/log/messages
# The authpriv file has restricted access.
authpriv.*                              /var/log/secure
# Log all the mail messages in one place.
mail.*                                   /var/log/maillog

# Log cron stuff
cron.*                                  /var/log/cron
# Everybody gets emergency messages
*.emerg                                                 *
# Save news errors of level crit and higher in a special file.
uucp,news.crit                    /var/log/spooler
# Save boot messages also to boot.log
local7.*                              /var/log/boot.log
```

- 각 행에 대한 설명

#kren.*  /dev/console
= 위의 설정은 kernel에 관련된 로그(klogd) 기록을 /dev/console(모니터)에 뿌려주라는 의미이다.

*.info;mail.none;authprive.none;cron.none    /var/log/messages
= 시스템 로그파일로써, *.info는 모든 서비스에 대한 info 레벨 그 이상의 메세지를 의미하고, mail.none은 메일에 관한 로그를 기록하지 않는다는 의미이다.
그리고 세미콜론으로 구분되어 있는 것은 각각의 Faculuty,Priority에 해당하는 설정을 동시에 여러개 지정하기 위함이다.

authpriv.*     /var/log/secure
= authpriv에 해당하는 데몬들에 대한 모든 상황에 대한 기록을 /var/log/secure 파일에 하라는 의미이다.
즉, authpriv에 속하는 서비스들(xinetd,telnet,ftp 등)에 대한 모든 상황발생에 대하여 /var/log/secure 로그파일엑 기록한다.
(이 경우 xinetd에 관련된 데몬들은 /etc/xinetd.d/* 파일에 설정되어 있으며, 해당되는 데몬들은 telnet, ftp, finger 등이다.)

mail.*  /var/log/mailong
= 메일에 관련된 모든 로그를 /var/log/maillong에 남기라는 의미이다.
(sendmail, qmail, ipop, imap 등)

cron.*  /var/log/cron 
= 시스템 크론데몬(crond)에 관련된 모든 로그를 /var/log/cron에 남기도록 한 설정이다.
cron 서비스에 해당하는 것은  crond 라는 데몬뿐 아니라 atd라는 예약작업 데몬도 이에 해당한다.

local7.*  /var/log/boot/log
= 시스템이 부팅될 때의 로그메세지로서 var/log/boot.log 파일에 그 기록을 저장한다.
시스템 부팅 메세지는 dmesg 명령어로 볼 수 있으며, /var/log/dmesg 파일을 열어봐도 알 수 있다.

---
