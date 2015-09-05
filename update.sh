cd `dirname $0`
cd flying-squid
status=`git pull`
echo $status
if [ "$status" != "Already up-to-date." ]
then 
	npm install
	pid=`ps -ef | awk '$8=="node" && $9=="app.js" {print $2}'`
	if [[ ${pid} != '' ]] ; then kill ${pid} ; fi
	screen -S flying-squid -d -m node app.js
fi
