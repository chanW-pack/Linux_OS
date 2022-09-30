# Linux OS config 정보 백업 (+ 네트워크 인터페이스 정보)

---

## Linux 네트워크 인터페이스 정보 백업

---

지난 OS config의 정보를 백업하는 스크립트에 네트워크 인터페이스 정보를 백업하는 기능을 추가하였다.

## ****Shell Scirpt (backup 파일 생성)****

---

![Untitled](Linux%20OS%20config%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%20%E1%84%87%E1%85%A2%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20(+%20%E1%84%82%E1%85%A6%E1%84%90%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%8F%E1%85%B3%20%E1%84%8B%E1%85%B5%E1%86%AB%E1%84%90%E1%85%A5%E1%84%91%E1%85%A6%E1%84%8B%E1%85%B5%206611a035a8eb48d0a836b78769c55aff/Untitled.png)

![Untitled](Linux%20OS%20config%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%20%E1%84%87%E1%85%A2%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20(+%20%E1%84%82%E1%85%A6%E1%84%90%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%8F%E1%85%B3%20%E1%84%8B%E1%85%B5%E1%86%AB%E1%84%90%E1%85%A5%E1%84%91%E1%85%A6%E1%84%8B%E1%85%B5%206611a035a8eb48d0a836b78769c55aff/Untitled%201.png)

```bash
#! /bin/bash

# date로 오늘 날짜를 불러온다.
today=`date +%m-%d-%y`
echo $today Perform a backup of server configuration information
sleep 1.0

mkdir /home/test/$today-monitoringTEST

# 저장될 백업데이터
df=`df -k > /home/test/$today-monitoringTEST/$today/df-$today.bak`
mount=`mount > /home/test/$today-monitoringTEST/$today/mount-$today.bak`
ifcon=`ifconfig > /home/test/$today-monitoringTEST/$today/ifconfig-$today.bak`
net=`netstat -lntp > /home/test/$today-monitoringTEST/$today/netstat-$today.bak`
route=`route > /home/test/$today-monitoringTEST/$today/route-$today.bak`
bond0=`cat /proc/net/bonding/bond0 > /home/test/$today-monitoringTEST/$today/bond0-$today.bak`
bond1=`cat /proc/net/bonding/bond1 > /dev/null`

if [ `echo $?` -eq 0 ] ; then
        echo -n "bond1"
        echo -e "\033[32m Ok \033[0m"
        bond1=`cat /proc/net/bonding/bond1 > /home/test/$today-monitoringTEST/$today/bond1-$today.bak`
else
        echo -n "bond1"
        echo -e "\033[31m None \033[0m"
        bond1="None"
fi

# 기준서버의 네트워크 인터페이스 목록
netlist="
eno5
eno6
eno7
eno8
ens1f0
ens1f1
ens1f2
ens1f3
"
# 네트워크 인터페이스의 사용 유무를 확인한다.
for nuser in $netlist
do
        if [ `ethtool $nuser | grep Speed: | awk '{ print $2 }'` != "Unknown!" ] ; then
        echo -n $nuser
        echo -e "\033[32m Ok \033[0m"
        $nuser=`ethtool $nuser > /home/test/$today-monitoringTEST/$today/$nuser-$today.bak`
else
        echo -n $nuser
        echo -e "\033[31m None \033[0m"
        $nuser="None"
fi
done

config="
$df
$mount
$ifcon
$net
$route
$bond0
$bond1
$eno5
$eno6
$eno7
$eno8
$ens1f0
$ens1f1
$ens1f2
$ens1f3
"
# 사용하지 않는 목록을 제외하고 데이터 저장 변수를 불러온다
for backup in $config
do
        if [ $backup != "None" ] ; then
                echo $backup
        fi
done

sleep 1.0
echo The server configuration information storage is complete.
```

기준이 되는 서버의 네트워크 인터페이스가 많아, 그 중 up 되어있는 인터페이스의 정보만을 백업하는 기능을 동료가 작성하고, 본인은 반복문으로 간소화만 시켜주었다.

(서버마다 up 되어있는 인터페이스가 제각각임)

## 테스트

---

![Untitled](Linux%20OS%20config%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%20%E1%84%87%E1%85%A2%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20(+%20%E1%84%82%E1%85%A6%E1%84%90%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%8F%E1%85%B3%20%E1%84%8B%E1%85%B5%E1%86%AB%E1%84%90%E1%85%A5%E1%84%91%E1%85%A6%E1%84%8B%E1%85%B5%206611a035a8eb48d0a836b78769c55aff/Untitled%202.png)

![Untitled](Linux%20OS%20config%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%87%E1%85%A9%20%E1%84%87%E1%85%A2%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20(+%20%E1%84%82%E1%85%A6%E1%84%90%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%8F%E1%85%B3%20%E1%84%8B%E1%85%B5%E1%86%AB%E1%84%90%E1%85%A5%E1%84%91%E1%85%A6%E1%84%8B%E1%85%B5%206611a035a8eb48d0a836b78769c55aff/Untitled%203.png)

> 순차적으로 네트워크 인터페이스를 확인 후 , Ok로 사용이 확인된 인터페이스 정보만 백업한다.
> 

---