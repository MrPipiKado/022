#!/bin/bash
for IP in "$@"
do
	netcat -v -z -n -w 1 $IP 80 >> tmp.txt 2>&1
	netcat -v -z -n -w 1 $IP 433 >> tmp.txt 2>&1
done
grep "succeeded" tmp.txt
rm -r tmp.txt
