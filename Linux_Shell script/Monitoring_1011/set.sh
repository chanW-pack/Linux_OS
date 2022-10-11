#!/bin/bash

today=`date +%Y-%m-%d`

i=1
while read line || [ -n "$line" ] ; do

  line_value=(`echo $line`)
  myHost=`echo $line | awk '{ print $1 }'`
  ping=`echo $line | awk '{ print $2 }'`

  if [ "$ping" == "True" ] ; then
        hostname=`echo -n $myHost`
        host_ok=`echo -e "\033[32m Ping Ok \033[0m"`

        mem=`echo $line | awk '{print $3}' | awk -F: '{print $2}'`

        if [ "$mem" -gt '80' ] ; then
            mem_ck=`echo -e "\033[31m Memory:$mem% \033[0m"`
        else
           if [ "$mem" -gt '10' ] ; then
              mem_ck=`echo -e "\033[32m Memory:$mem% \033[0m"`
            else
              mem_ck=`echo -e "\033[32m Memory: $mem% \033[0m"`
           fi
        fi

        cpu=`echo $line | awk '{print $4}' | awk -F: '{print $2}'`

        if [ "$cpu" -gt '80' ] ; then
            cpu_ck=`echo -e "\033[31m Cpu:$cpu% \033[0m"`
        else
           if [ "$cpu" -gt '10' ] ; then
              cpu_ck=`echo -e "\033[32m Cpu:$cpu% \033[0m"`
           else
              cpu_ck=`echo -e "\033[32m Cpu: $cpu% \033[0m"`
           fi
        fi

       total_length=${#line_value[@]}
       mydisk=(`echo $line | awk '{k=""; for(i=5; i<='$total_length'; i++) k = k $i" "; print k}'`)
       disk=${#mydisk[@]}

        echo  ===========================
        echo $today Server Check Task List ... $hostname
        echo $host_ok $mem_ck $cpu_ck

        for ((var=1; var <= $disk; var++));
        do
                disk_set=(`echo ${mydisk[@]} | awk -F " " '{print $'"$var"'}'`)
                disk_var=(`echo ${mydisk[@]} | awk -F " " '{print $'"$var"'}' | awk -F: '{print $2}' | tr -d '%'`)
                if [ "$disk_var" -gt '80' ] ; then
                        disk_ck=`echo -e "\033[31m $disk_set \033[0m"`
                elif [ "$disk_var" -gt '60' ] ; then
                        disk_ck=`echo -e "\033[33m $disk_set \033[0m"`
                else
                        disk_ck=`echo -e "\033[32m $disk_set \033[0m"`
                fi
                echo $disk_ck
        done

  else
        echo -n $myHost
        echo -e "\033[31m False \033[0m"
  fi
  ((i+=1))
done < allServer-$today
# NFS mount checker
# $1=host $2=ping $3=mem $4=cpu $5~=disk(10~)
#  echo ${mydisk[@]}
