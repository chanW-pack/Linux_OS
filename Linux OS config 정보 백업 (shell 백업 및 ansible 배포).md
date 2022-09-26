# Linux OS config 정보 백업 (shell 백업 및 ansible 배포)

---

기능 구현 목적 
다수의 서버들의 재기동(재부팅) 등 작업 전 OS 정보들을 미리 백업하려 한다.

config 정보 백업 파일을 생성하는 스크립트를 구성하고, 이를 서버들에 배포하여야 한다.
(각 서버에 스크립트가 배치되어야 한다.)

백업 파일은 실행 날짜를 기재하여 구별이 어렵지 않게 구성하였다.

## Shell Scirpt (backup 파일 생성)

---

![Untitled](https://user-images.githubusercontent.com/84123877/192235386-1ff3940e-4346-45cd-9ae2-198be400275e.png)

```bash
#! /bin/bash

######################
# 0926 os config data backup
######################

# date로 날짜 얻기, "MM-DD-YY" 형식으로 날짜 출력
today=`date +%m-%d-%y`
echo $today Perform a backup of server configuration information
sleep 1.0

mkdir /home/env_con/$today

# 기존 정보 백업
df=`df -k > /home/env_con/$today/df-$today.bak`
mount=`mount > /home/env_con/$today/mount-$today.bak`
ifcon=`ifconfig > /home/env_con/$today/ifconfig-$today.bak`
net=`netstat -lntp > /home/env_con/$today/netstat-$today.bak`
route=`route > /home/env_con/$today/route-$today.bak`

config="
$df
$mount
$ifcon
$net
$route
"

for backup in $config
do
        echo $backup
done

sleep 1.0
echo The server configuration information storage is complete.
```

date로 얻은 실행 결과(날짜)를 today 변수에 저장하여 사용했다.

today 변수는 스크립트 실행시 날짜를 나타내며, 디렉터리 및 파일 생성에 이용된다.

이후 df, mount, netstat, ifconfig, route의 정보를 파일로 백업한다.

## Anible playbook (스크립트 배포)

---

![Untitled 1](https://user-images.githubusercontent.com/84123877/192235371-db0a0e49-f364-4b6a-bdd3-23f78a79bd1e.png)

```yaml
---
  - hosts: all
    name: server config file copy all server
    gather_facts: false
    become: true

    tasks:
      - copy:
          src: /home/ansible/deploy-inventory/ansibleHistory/0924/configBack.sh
          dest: /home/env_con/configBack.sh

      - shell: ls -la /home/env_con | grep configBack.sh
        ignore_errors: yes
        register: bin

      - debug:
         var: bin.stdout_lines
```

생성된 스크립트를 각 서버에 배포하기 위해 ansible playbook을 작성한다.

copy 모듈을 사용하여 각 서버에 지정된 디렉터리로 복사한다.

이후 작업 성공 여부 확인을 위해 ls -la 데이터를 bin regisrer에 저장하여 debug창으로 나타낸다.

## 테스트 결과

---

![Untitled 2](https://user-images.githubusercontent.com/84123877/192235383-46883b95-0b6d-4f7b-83ff-53e2f9438861.png)

/home 디렉터리에 date로 불러온 날짜의 디렉터리가 생성되고, 그 안에 각 명령어에 대한 정보 파일이 날짜와 함꼐 저장된것을 확인 가능하다.

---
