# Deploy
Upload 4 Service

## Setting Server (ubuntu)

### install java 1.8
`sudo apt-get install openjdk-8-jdk`

### install Ngix
`sudo apt install nginx`

### Ngix Setting
```
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
```

## Spring Server Upload

### Build Spring boot maven project

![mavenBuild](/image/SpringMavenBuild.PNG)

### go to `projectname/target`

copy war(jar) file and paste to server's deploy path

## Spring Server Run

```
sudo mkdir ~/Deploy
sudo vim ~/Deploy/deploy.sh
```

### deploy.sh

```
#!/bin/bash

REPO=/home/user/Deploy

cd $REPO/

echo "> Git Pull"

git pull

echo "> 현재 구동중인 애플리케이션 pid 확인"

CURRENT_PID=$(pgrep -f WRITE YOUR WAR/JAR FILE NAME)

echo "$CURRENT_PID"

if [ -z $CURRENT_PID ]; then
    echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
    echo "> kill -15 $CURRENT_PID"
    kill -15 $CURRENT_PID
    sleep 5
fi

echo "> 새 어플리케이션 배포"

JAR_NAME=$(ls $REPO/ |grep 'WRITE YOUR WAR/JAR FILE NAME' | tail -n 1)

echo "> JAR Name: $JAR_NAME"

nohup java -jar $REPO/$JAR_NAME &
```


## React Upload

### `yarn build`

copy created build folder and paste to server's deploy path


## Run React

### Go Ngix Setting path
```
cd /etc/nginx/sites-available/
sudo touch myapp.conf
```

### myapp.conf
```
server {
  listen 80;
  location / {
    root   /home/user/myapp/build;
    index  index.html index.htm;
    try_files $uri $uri/ /index.html;
  }
}
```

### copy myapp.conf to unbuntu's default running

```
sudo ln -s /etc/nginx/sites-available/myapp.conf /etc/nginx/sites-enabled/myapp.conf
sudo systemctl stop nginx
sudo systemctl start nginx
```
