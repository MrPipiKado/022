#!/usr/bin/env bash
apt-get update
apt install -y default-jdk
apt install -y default-jre
apt-get upgrade -y
echo "JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"" >> /etc/environment
source /etc/environment

mkdir ~/confluence
cd ~/confluence/
if [[ !( -f atlassian-confluence-7.3.1.tar.gz ) ]]
then 
	wget https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-7.3.1.tar.gz
fi
tar -xzvf atlassian-confluence-7.3.1.tar.gz 
chmod -R u=rwx,go-rwx ~/confluence/
mkdir /var/confluence-home
chmod -R u=rwx,go-rwx /var/confluence-home/
echo -e "\nconfluence.home=/var/confluence-home" >> /root/confluence/atlassian-confluence-7.3.1/confluence/WEB-INF/classes/confluence-init.properties
cd /root/confluence/atlassian-confluence-7.3.1/bin/
./start-confluence.sh
