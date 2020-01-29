#!/bin/bash

DATE=`date +"%Y%b%d"`
if [[ $# != 2 ]]
then
	setterm -foreground red 
	echo "Apropriate usege: backup.sh source_dir backup_dir"
	setterm -foreground white 

fi
if [[ !(-d $1) ]]
then
	setterm -foreground red 
	echo "Source dir $1 does non exist"
	setterm -foreground white 
	
fi
if [[ !(-d $2) ]]
then
	setterm -foreground red 
	echo "Backup dir $2 does non exist"
	setterm -foreground white
fi


if [[ !(-d $2"/"$DATE) ]]
then
	cd $2
	mkdir $DATE
	cd ..
fi

cd $1

NEEDBACKUP=`find ./ -maxdepth 1 -newermt "-24 hours" -ls`
for file in $NEEDBACKUP
do
	if [[ -f $file ]]
	then
		if [[ -f ../$2/$DATE/$file ]]
		then
			rm -f ../$2/$DATE/$file
		fi

		cp -a $file ../$2/$DATE

		if [[ -f ../$2/$DATE/$file ]]
		then
			setterm -foreground green 
			echo "$file backuped"
			setterm -foreground white 
		fi

	fi
	if [[ (-d $file) && ($file != ./) ]]
	then
		if [[ -d ../$2/$DATE/$file ]]
		then
			rm -f -r ../$2/$DATE/$file
		fi

		cp -aR $file ../$2/$DATE/

		if [[ -d ../$2/$DATE/$file ]]
		then
			setterm -foreground green 
			echo "$file dir fully backuped"
			setterm -foreground white 

		fi

	fi

done

