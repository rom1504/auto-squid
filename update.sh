#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $dir
if [ -a .installing ]
then
exit 0
fi
touch .installing
cd flying-squid
status=`git pull`
echo $status
pid=`ps axo args,pid,user | awk '$1=="node" && $2=="app.js" && $4=="flying-squid" {print $3}'`
if ([ "$status" != "Already up-to-date." ] && [ "$status" != "" ] ) || [ "$ALWAYS_UPDATE" == "1" ] || [ "$pid" == "" ]
then 
	echo "installing and starting "
	echo "status: $status"
	echo "pid: $pid"
	npm install
	if [[ "$pid" != "" ]] ; then kill ${pid} ; fi
	screen -S flying-squid -d -m ../start.sh
fi
cd $dir
rm .installing
