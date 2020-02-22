!/bin/bash

REPO=/home/ubuntu/Deploy

cd REPO

echo "> Git Pull"

sudo git pull

echo "> 구동중인 pid 확인"

CURRENT_PID=$(pgrep -f Back-0.0.1-SNAPSHOT)

echo "$CURRENT_PID"

if [ -z $CURRENT_PID ]; then echo ">실행중 아님"
else echo "> kill -15 $CURRENT_PID 종료"
	kill -15 $CURRENT_PID
	sleep 5
fi

WAR_NAME=$(ls $REPO/ |grep 'Back-0.0.1-SNAPSHOT' | tail -n 2)

echo "> WAR_NAME: $WAR_NAME"

nohup java -jar $REPO/$WAR_NAME &
