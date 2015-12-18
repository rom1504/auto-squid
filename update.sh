#!/bin/bash

cd `dirname $0`
cd flying-squid
status=`git pull`
echo $status
pid=`ps -ef | awk '$8=="node" && $9=="app.js" {print $2}'`
if ([ "$status" != "Already up-to-date." ] && [ "$status" != "" ] ) || [ "$ALWAYS_UPDATE" == "1" ] || [ "$pid" == "" ]
then 
	echo "installing and starting "
	echo "status: $status"
	echo "pid: $pid"
	npm install
	if [[ "$pid" != "" ]] ; then kill ${pid} ; fi
	screen -S flying-squid -d -m ../start.sh
fi
