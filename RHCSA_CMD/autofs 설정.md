# autofs 설정

---

### autofs 설정

다음과 같이 원격 사용자의 홈 디렉터리를 자동으로 마운트 하도록 autofs를 구성한다.

시스템으로 `utility.net1.example.com NFS-exports /ruserds`를 제공한다.

이 파일 시스템에는 사용자 `remoteuser1`에 대해 미리 구성된 홈 디렉터리가 포함되어 있다.

`remoteuser1` 의 홈 디렉터리는 `utility.net1.example.com:/rusers/remouteuser1` 이다.

`remoteuser1` 의 홈 디렉터리는 `/rusers/remoteuser1`로서 로컬에서 자동으로 마운트되어애 한다. 

홈 디렉터리는 사용자가 작성 할 수 있어야 한다.

`remoteuser1`의 암호는 `flectrage` 이다.

### * 자동 마운터는 클라이언트 측에서 구성된다.

```bash
# autofs 설치
yum -y install autofs

Complete!

systemctl enable --now autofs
Created symlink /etc/systemd/system/multi-user.target.wants/autofs.service → /usr/lib/systemd/system/autofs.service.
vi /etc/auto.master.d/direct.autofs
/- /etc/auto.direct

vi /etc/auto.direct
/rusers/remoteuser1 -rw,sync,fstype=nfs4 utility.net1.example.com:/rusers/remoteuser1

systemctl restart autofs.service
su - remoteuser1
```

### NFS

mount 명령을 사용하고 이는 관리자만 사용이 가능하다.

즉, 일반 사용자가 자원을 마운트하여 사용이 불가능 한 것.

(USB CD-ROM 같은 외장 스토리지 제외~)

서버에서 export가 되고 있는 상황

관리자가 fstab, mount 명령을 통해서 실제로 작업이 가능한 상태로 mount 해 주어야 자원을 사용 가능하다.

autofs를 사용하게 되면 관리자가 없더라도 일반 사용자가 원하면

언제든지 접근,요청이 있는 경우에만 접근하고,   

일정시간 사용하지 않는다면 자동으로 umount 시킨다.

두 가지 매핑을 지원한다.

```bash
1. 마스터 맵
마운트 지점의 기본 디렉터리 확인 자동 마운트 생성용 파일
/share1 /etc/autofs.direct 간접
/- /etc/autofs.direct      직접

2.1 간접 맵
doc1 -rw.sync 192.168.10.11:/stage1/doc1
* -rw,sync 192.168.10.11:/stage1/& < 두개 이상의 디렉터리가 동일한 상위 디렉터리를 가지고 있는 경우

2.2 직접 맵
/share1/doc1 -rw,sync 192.168.10.11:/stage1
```

```jsx
#요약
dnf install -y autofs
vi /etc/auto.master.d/direct.autofs
/- /etc/auto.direct

vi /etc/auto.direct
/cwclient -rw,sync 172.16.0.99:/cwhost
wq

systemctl enable --now autofs
systemctl status autofs

이후 df나 mount 명령으로는 확인해도 안나타난다.
cd 등으로 해당 디렉터리를 직접 이동하거나 사용하는 경우에 autofs가 활성화되어 mount된다.
신기하죵??
```

---
