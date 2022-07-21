# Linux chage 사용자 패스워드 만기 정보 관리

---

## chage란?

---

사용자의 패스워드 만기 정보를 변경 및 설정하는 명령어이다.
(root 권한을 가진 사용자만 사용 가능)

즉, 사용자 패스워드 정보 관리 명령어이며, 시스템에게 로그인한 사용자가 패스워드를 변경해야 하는지를 알려준다.

## 옵션

---

- - l (L) : 특정 계정의 정보 확인
- - d : 최근 패스워드 변경 날짜 확인
- - E : 계정 만료일을 설정
- - m : 패스워드 최소 의무 사용일 수를 지정
- - M : 패스워드 최종 변경일로부터 패스워드 변경 없이 사용할 수 있는 최대 일수 설정
- - I (i) : 패스워드 만료일까지 패스워드를 바꾸지 않으면 계정 만료(비활성화) 설정 옵션
- - W : 패스워드 만료 몇일 전부터 사용자에게 경고 메세지 발송 설정

![Untitled](Linux%20chage%20%E1%84%89%E1%85%A1%E1%84%8B%E1%85%AD%E1%86%BC%E1%84%8C%E1%85%A1%20%E1%84%91%E1%85%A2%E1%84%89%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%83%E1%85%B3%20%E1%84%86%E1%85%A1%E1%86%AB%E1%84%80%E1%85%B5%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%20%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5%20498e55c195fe4f8da25a78aa25afa16f/Untitled.png)

## 패스워드 만료일 갱신 및 확인

---

1. 만료일 확인

```bash
chage -l 계정명 | grep -i '^password expires'
```

1. 만료일 갱신

```bash
chage -d 갱신한 일자 계정명 -> chage -d 2020-03-01 linuxuser
```

1. 만료기한 변경

```bash
chage -M기간 계정명 -> chage -M90 linuxuser
```

1. 계정 만료 안되게 진행

```
chage -E -1 -m 0 -M 99999 계정명
# E -1
# m 0
# M 99999
```

 4. 계정 만료 안되게 진행 을 더 자세하게 설명하자면, 
비밀번호가 없는 서비스의 계정에 경우 비밀번호 변경 사이의 최대 일수를 무제한으로 만들어주어야 한다. 

해당 경우의 비밀번호 설정은 다음과 같다.

```bash
[root@hostname ~]# chage -l root
Last password change                                    : never
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : never
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7
```

```bash
[root@hostname ~]# chage -l apache
Last password change                                    : Feb 10, 2020
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : never
Minimum number of days between password change          : -1
Maximum number of days between password change          : -1
Number of days of warning before password expires       : -1
```

> ‘암호 변경 사이의 최대 일수’ 에서 ‘99999’ 와 ‘-1’의 값은 암호가 만료되지 않음을 나타낸다.
> 

암호가 설정되지 않은 계정에 대해서는 해당 설정을 고려해야 한다.

(본인도 99999로 설정하다 -1 로 설정되어있는것을 보고 혼란이 왔는데 결국 같은 의미였다..)

## /etc/shadow 파일과의 연계성

---

리눅스 사용자의 정보는 /etc/passwd 파일에 기록되고 있다.

하지만, /etc/passwd 파일의 2번째 필드인 패스워드 항목은 보안상의 문제로 /etc/shadow라는 파일에서 별도로 관리되고 있다.

chage도 패스워드에 대한 정보를 수정하는 명령어이기 때문에 명령이 성공적으로 수행되면 /etc/shadow 파일도 동시에 업데이트가 된다.

```bash
yhjeong@ubuntu:/$ sudo cat /etc/shadow | grep user2
user2:*:18473:6:180:10:10:18627:
```

> 예제로, user2의 패스워드 정보를 살펴본다.
> 

![Untitled](Linux%20chage%20%E1%84%89%E1%85%A1%E1%84%8B%E1%85%AD%E1%86%BC%E1%84%8C%E1%85%A1%20%E1%84%91%E1%85%A2%E1%84%89%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%83%E1%85%B3%20%E1%84%86%E1%85%A1%E1%86%AB%E1%84%80%E1%85%B5%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%20%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5%20498e55c195fe4f8da25a78aa25afa16f/Untitled%201.png)

> ‘:’ 로 구분되어, 총 9개의 필드로 구성된 /etc/shadow 파일의 각 필드 정보는 다음과 같다.
> 

![Untitled](Linux%20chage%20%E1%84%89%E1%85%A1%E1%84%8B%E1%85%AD%E1%86%BC%E1%84%8C%E1%85%A1%20%E1%84%91%E1%85%A2%E1%84%89%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%83%E1%85%B3%20%E1%84%86%E1%85%A1%E1%86%AB%E1%84%80%E1%85%B5%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%20%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5%20498e55c195fe4f8da25a78aa25afa16f/Untitled%202.png)

> 각 필드를 chage 명령어의 옵션과 연관 지어 본다면 다음과 같이 정리할 수 있다.
> 

---