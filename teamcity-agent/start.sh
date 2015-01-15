#!/bin/bash

trap "/opt/agent/bin/agent.sh stop" SIGINT SIGTERM
/opt/agent/bin/agent.sh start
pid=`cat /opt/agent/logs/buildAgent.pid`

while kill -0 $pid 2> /dev/null;
do
  sleep 1
done
