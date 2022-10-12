#! /bin/bash

today=`date +%Y-%m-%d`

FILE=/home/shell/monitoring/allServer-$today
echo Loading Server Check Tasklist..
sleep 0.5

if [ -e $FILE ] ; then
        echo "The file already exists. Let's move on to data loading"
else
        ansible-playbook -i host bul.yaml
fi

sleep 1.0

echo Analyzing inspection data..
echo -ne '##### (33%)\r'

sleep 1

echo -ne '############# (66%)\r'

sleep 1

echo -ne '####################### (100%)\r'

echo -ne '\n'

. command.sh
#echo Information to check: hardware"|"nslookup"|"route"|"bond0"|"chrony
#nn=$(nslookup)

while true; do
        sleep 1.0
        echo " "
        echo ----------------------------------------------------------------------
        echo Information to check: hardware"|"nslookup"|"route"|"chrony or type "<"exit">" to quit
        echo ----------------------------------------------------------------------
        read setData
        case $setData in
                exit) break ;;
                hardware) ./set.sh ;;
                nslookup) nslookup ;;
                route)  route ;;
                chrony) chrony ;;
                *) echo "Unknown response, enter a Information or type exit to quit" ;;
        esac
done
