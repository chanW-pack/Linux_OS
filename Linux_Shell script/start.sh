#! /bin/bash

echo Loading Server Check Tasklist..
sleep 1.0
ansible-playbook -i host bul.yaml

echo Analyzing inspection data..
echo -ne '##### (33%)\r'

sleep 1

echo -ne '############# (66%)\r'

sleep 1

echo -ne '####################### (100%)\r'

echo -ne '\n'
sleep 1

./set.sh
