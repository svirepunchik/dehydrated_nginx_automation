#!/bin/bash

# 2018-03-28 svirepunchik@gmail.com

# log file location & name
logfile=/var/log/nginx/dna.log

# flag file location & name
flag=/opt/dna/hasnewcerts.flag

# path to nginx binary
nginx=`which nginx`

mkdir -p `dirname $logfile`

if [[ -f $flag ]]; then
    echo $(date +"%Y-%m-%d %H:%M:%S") found new certs from dehydrated. starting nginx config test >> $logfile
    $nginx -t >> $logfile
    if [[ $? -eq 0 ]]; then
	echo $(date +"%Y-%m-%d %H:%M:%S") OK. restarting nginx >> $logfile
	service nginx restart >> $logfile
	if [[ $? -eq 0 ]]; then
	    echo $(date +"%Y-%m-%d %H:%M:%S") OK. finishing >> $logfile
	    rm -rf $flag
	    exit 0
	else
	    echo $(date +"%Y-%m-%d %H:%M:%S") FAIL: nginx restart failed. exiting >> $logfile
	    exit 1
	fi
    else
	echo $(date +"%Y-%m-%d %H:%M:%S") FAIL: nginx config test failed. exiting >> $logfile
	exit 2
    fi
fi
