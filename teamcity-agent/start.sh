#!/bin/bash

service ssh start

trap "/opt/agent/bin/agent.sh stop" SIGINT SIGTERM
trap "/opt/agent/bin/agent.sh stop kill" SIGKILL

/opt/agent/bin/agent.sh start
sleep 5

while ps aux | grep java > /dev/null;
do
  sleep 1
done
