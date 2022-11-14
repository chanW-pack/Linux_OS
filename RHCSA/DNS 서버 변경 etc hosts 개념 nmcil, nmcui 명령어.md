# DNS 서버 변경 /etc/hosts 개념 / nmcil, nmcui 명령어

---

# DNS 서버 변경

### 1. resolv.conf 파일변경으로 DNS 바꾸기

![Untitled](https://user-images.githubusercontent.com/84123877/201677958-0db2750a-b115-44f9-a543-3097f81baf65.png)

nslookup 으로 dns 확인

![Untitled 1](https://user-images.githubusercontent.com/84123877/201677923-a63f6a4a-dfc5-4e6d-a306-518c3912e8dc.png)

vi 편집기로 dns를 8.8.8.8 로 변경 후 :wp 로 저장

![Untitled 2](https://user-images.githubusercontent.com/84123877/201677927-9d0a953f-f2bb-41b4-83b0-b58d9a8ab07f.png)

바뀐 모습 확인이 가능하다.

### 2. 네트워크 설정파일 수정

/etc/sysconfig/network-scripts/ifcfg-ens33 경로에서 네트워크 설정파일 수정 가능하다.

+ sysconfig 디렉터리가 존재하지 않는 경우, /etc/network/interfaces 디렉터리로 변경되었을 것 (os 버전 별로 상이함)

```
본인의 테스트 환경의 경우(ubuntu 20.04)
/etc/sysconfig, /etc/network 두 경로가 모두 미존재인 상태였음.
조사해보니,
ubuntu 최신 버전의 경우 기본적으로 netplan 방식의 ip 설정 툴을
이용한다고 함
(etc/netplan/00-network-manager-all.yaml 등)

결과적으로, 기존의 ifup, ifdown 형태의 /etc/network/interface 형태를
원하는 경우, inupdown 패키지를 추가로 설치하여야 함
```

`# apt install ifupdown <== ifupdown 패키지 설치`

`# apt remove netplan.io <== 기존 netplan 제거`

`# systemctl enable networking <== 네트워크 자동 기동 설정`

`# systemctl restart networking <== 네트워크 리스타트`

![Untitled 3](https://user-images.githubusercontent.com/84123877/201677928-1f38381f-c813-42e7-b076-2d6aedd92fea.png)

ifcfg-ens33 파일 vi 편집기로 확인.

 

![Untitled 4](https://user-images.githubusercontent.com/84123877/201677933-f555ba68-73dc-4f0c-b985-12fbe785b22a.png)

DNS1 이라고 되어있는 부분에 전 DNS 값 입력

![Untitled 5](https://user-images.githubusercontent.com/84123877/201677935-f1daa05c-b3e3-4a78-a156-cc4828ab4599.png)

설정 후 네트워크를 재시작하면 DNS값이 다시 바뀐 것을 확인 가능하다.

# /etc/hosts 개념 및 수정 실습

/etc/hosts 파일은 운영 체제가 호스트 이름을 IP 주소에 매핑할 때 사용하는 컴퓨터이다.

즉 hosts 파일에 등록해둔 IP와 호스트 이름이 있으면 해당 호스트 이름으로 접근을 할 때 설정해둔 IP 주소로 접근을 하게 된다.

![Untitled 6](https://user-images.githubusercontent.com/84123877/201677937-a2907a19-5a4f-4f4f-87b9-2987534b4f7a.png)

/etc/hosts 파일을 확인해보면 ipv4와 ipv6주소 및 localhost가 설정되어있다.

여기서 223.130.195.200(naver ip)를 chanwoo.com을 입력하면 접속되게 설정해 보겠다.

![Untitled 7](https://user-images.githubusercontent.com/84123877/201677941-cd18e37d-cfde-4bf3-b129-0f7439b84cf2.png)

파일 수정 후 :wq로 저장

![Untitled 8](https://user-images.githubusercontent.com/84123877/201677944-a29d5a35-1638-4d11-8099-0fc69dc43fba.png)

![Untitled 9](https://user-images.githubusercontent.com/84123877/201677945-63297ade-6c95-41db-a253-01a10f9dd258.png)

[chanwoo.com](http://chanwoo.com) 입력 시, 네이버로 접속되는 모습을 확인할 수 있다.

# nmcli, mntui를 사용하여 네트워크 변경

nmcli, nmtui란 네트워크 설정을 변경할 수 있게 해주는 network manager 명령어이다.

- nmtui :
콘솔에서 사용 가능한 TUI N/W 설정 프로그램
- nmcli :
콘솔에서 사용 가능한 명령어 기반 CUI N/W 설정 프로그램

![Untitled 10](https://user-images.githubusercontent.com/84123877/201677948-f4bb1402-0b72-4262-95ca-2e9fb1220714.png)

`ifconfig`로 ens160의 ip를 확인한다. (172.16.0.77)

> 왜인지는 모르겠지만 ens160을 못찾음. uuid로 진행하니 실습은 가능하나, 왜 안될까??

![Untitled 11](https://user-images.githubusercontent.com/84123877/201677950-c9fc9a9a-1d61-41ca-8562-04c4b358a71e.png)

name이 유선 연결이라 안되는듯하다.

![Untitled 12](https://user-images.githubusercontent.com/84123877/201677951-db3937d7-170f-45a8-a780-e47586a9dbed.png)

```bash
# 디바이스 명을 인식하지 못해, uuid로 설정을 진행하였다.
$ nmcil con mod uuid d2ca5d82-8b26-3279-b9b7-a7aa554d344d
ivp4.addresses 172.16.0.88/24

# 설정 이후 네트워크 장치 활성화
$ nmcil con up uuid d2ca5d82-8b26-3279-b9b7-a7aa554d344d
```

172.16.0.77 → 172.16.0.88 로 ip를 변경하였다.

ssh로 접근하고 있어, 재 접속이 필요하다.

![Untitled 13](https://user-images.githubusercontent.com/84123877/201677956-3c0735cb-514d-4611-a223-e29969ae3eb2.png)

ifconfig 로 확인해보면 172.16.0.88으로 정상적으로 변경된 것을 확인 가능하다.

---
