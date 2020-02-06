#!/usr/bin/env bash
apt-get update
apt-get install mysql-server -y
sudo mysql -e 'use mysql;

update user set authentication_string=PASSWORD("123456") where User="root";

flush privileges;

CREATE DATABASE CONFLUENCE;

quit'

/etc/init.d/mysql start

cd /vagrant 
chmod +x atlassian-confluence-7.3.1-x64.bin
./atlassian-confluence-7.3.1-x64.bin -q -varfile /vagrant/response.varfile
cd /opt/atlassian/confluence7_3_1/bin
./start-confluence.sh
