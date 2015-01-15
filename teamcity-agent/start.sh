#!/bin/bash

trap "/opt/agent/bin/agent.sh stop" SIGINT SIGTERM
trap "/opt/agent/bin/agent.sh stop kill" SIGKILL
/opt/agent/bin/agent.sh start

while ps aux | grep java > /dev/null;
do
  sleep 1
done
