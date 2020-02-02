#!/bin/bash
DATE=`date +"%Y%b%d"`
CRONFILE="/var/spool/cron/root"
UPDATECONF="/etc/logrotate.d/update.conf"

if [[ !(-f /var/log/update-$DATE.log) ]]
then
	touch /var/log/update-$DATE.log
fi
sudo apt-get update -y -q > /var/log/update-$DATE.log 2>&1
sudo apt-get upgrade -y -q > /var/log/update-$DATE.log 2>&1

if [[ !(-f $CRONFILE) ]]
then
   sudo touch $CRONFILE
   sudo /usr/bin/crontab $CRONFILE
fi
sudo grep -qi "auto_update" $CRONFILE
if [[ $? != 0 ]]
then
   	sudo echo "0 0 * * 0 ${PWD}/auto_update.sh" >> $CRONFILE
fi
if [[ !(-f $UPDATECONF) ]]
then
	touch $UPDATECONF
	echo "/var/log/update-* {
    monthly
    create 0644 root root
    rotate 3
    notifempty
    compress
}" > $UPDATECONF
sudo chmod +x $UPDATECONF
/usr/sbin/logrotate $UPDATECONF
fi
