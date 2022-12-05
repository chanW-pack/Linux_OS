# NFS

---

NFS

```bash
# nfs utils 설치
yum install nfs-utils -y

# 프로세스 실행
systemctl status nfs-server.service
systemctl enable --now nfs-server.service

# 디렉터리 생성 및 디스크 파일시스템 생성
lsblk
mkdir /cwNFS-server
mkfs.xfs /dev/sdc

# fstab 자동 마운트 등록
vi/etc/fstab
/dev/sdc  /cwNFS-server xfs default 0 0
wq!

mount -a
mount | grep /dev/sdc

# NFS 디렉터리 지정
# [공유할 디렉터리] [허용할 아이피] [설정 옵션]
vi /etc/exports
/cwNFS-server  *(rw,no_root_squash)

# NFS 서비스 실행 및 현재 공유디렉터리 확인
exportfs -rav
exportfs -s 
showmount -e

# NFS 방화벽 설정 (새로운 존 추가 permanent)
firewall-cmd --permanent --add-service=nfs
success
firewall-cmd --reload
success
```

### Client

```bash
yum install -y nfs-utils
systmectl enable --now nfs-server-service

# 마운트 진행할 디렉터리 생성
mkdir /cwNFS2-server

# fstab 등록 및 마운트 진행
vi /etc/fstab
172.16.0.177:/cwNFS-server  /cwNFS2-server nfs defaults 0  0
wq!

mount -a
df | grep cwNFS
mount | grep cwNFS
```

### exports 설정 옵션

```bash
>설정옵션

rw : 읽기,쓰기

ro : 읽기전용

sync : 파일시스템 변경시 즉시 동기화

secure : 클라이언트의 마운트요청시 1024이하의 포트를 사용

noaccess : 액세스거부

root_squach : 클라이언트의 서버root권한 획득을 막기(default)

서버에서 생성된 파일을 수정못함

no_root_squash : 클라이언트 root계정과 서버의 root계정을 동일하게봄

서버에서 생성된 파일 수정가능

all_squach : root를 제외하고 서버와 클라이언트의 사용자를 동일한 권한으로 설정

no_all_squach : root를 제외하고 서버와 클라이언트의 사용자들을 하나의 권한을 가지도록 설정
```

### exportfs의 주요 옵션

```bash
>exportfs의 주요 옵션

-a : /etc/exports파일을 참조하여 NFS공유리스트를 갱신

-r : /etc/exports파일을 참조하여 NFS공유리스트를 재갱신

-u [IP:디렉토리] : NFS공유리스트에서 -u옵션으로 입력한 디렉토리는 제외

-v : 현재 NFS공유리스트를 출력

-s : 현재 NFS 설정 정보 확인
```

---