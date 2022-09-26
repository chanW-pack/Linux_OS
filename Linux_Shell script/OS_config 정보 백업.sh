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
