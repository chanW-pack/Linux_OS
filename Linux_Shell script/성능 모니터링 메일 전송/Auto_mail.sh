#!/bin/sh

#MEMORY 사용율
MEMORY_TOTAL=`free | grep ^Mem | awk '{print $2}'`
MEMORY_NOMINAL_USED=`free | grep ^Mem | awk '{print $4}'`
MEMORY_ACTUAL_USED=`free | grep ^Mem | awk '{print $7}'`

MEMORY_NOMINAL_PERCENT=$((100*(MEMORY_TOTAL-MEMORY_NOMINAL_USED)/MEMORY_TOTAL))
MEMORY_ACTUAL_PERCENT=$((100* (MEMORY_TOTAL-MEMORY_ACTUAL_USED)/MEMORY_TOTAL))

#CPU 사용율
CPU_PERCENT=`top -b -n 1 | grep -i cpu\(s\)| awk -F, '{print $4}' | tr -d "%id," | awk '{print 100-$1}'`

#DISK 사용율
DISK_TOTAL=`df -P | grep -v ^Filesystem | awk '{sum += $2} END { print sum; }'`
DISK_USED=`df -P | grep -v ^Filesystem | awk '{sum += $3} END { print sum; }'`
DISK_PERCENT=$((100*$DISK_USED/$DISK_TOTAL))

echo 명목메모리 사용량: $MEMORY_NOMINAL_PERCENT %, 실질 메모리 사용량: $MEMORY_ACTUAL_PERCENT %,  CPU사용량: $CPU_PERCENT %
echo 총 DISK용량: $(($DISK_TOTAL/1024/1024)) GB, DISK사용 용량: $(($DISK_USED/1024/1024)) GB,  DISK사용량: $DISK_PERCENT %


#!/bin/bash
TO_EMAIL="cwpack@hongikit.com mjk9923@hongikit.com"
SUBJECT="쉘스크립트 메일 전송테스트"
EMAIL_MSG="echo 명목메모리 사용량: $MEMORY_NOMINAL_PERCENT %, 실질 메모리 사용량: $MEMORY_ACTUAL_PERCENT %,  CPU사용량: $CPU_PERCENT %
echo 총 DISK용량: $(($DISK_TOTAL/1024/1024)) GB, DISK사용 용량: $(($DISK_USED/1024/1024)) GB,  DISK사용량: $DISK_PERCENT %"

echo "$EMAIL_MSG" | /bin/mail -s "$SUBJECT" "$TO_EMAIL"
