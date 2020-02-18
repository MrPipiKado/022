#!/usr/bin/env bash
apt-get install docker-compose -y

docker login -u "mrpipikado" -p "Marki2310"

docker build -t mydb /vagrant/db
docker build -t mywp /vagrant/wp

docker tag mydb:mydb devopsepam:mydb
docker push mrpipikado/devopsepam:mydb

docker tag mywp:mywp devopsepam:mywp
docker push mrpipikado/devopsepam:mywp

mkdir ~/WPamdMYSQL
cd ~/WPamdMYSQL/
touch docker-compose.yml
echo "version: '3.3'

services:
   db:
     image: mydb:latest
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: somewordpress
       MYSQL_DATABASE: somewordpress
       MYSQL_USER: somewordpress
       MYSQL_PASSWORD: somewordpress

   wordpress:
     depends_on:
       - db
     image: mywp:latest
     ports:
       - "8000:80"
     restart: always
     volumes: ['./:/var/www/html']
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: somewordpress
       WORDPRESS_DB_PASSWORD: somewordpress
       WORDPRESS_DB_NAME: somewordpress" >> docker-compose.yml
docker-compose up -d
