#!/bin/bash

trap "/opt/agent/bin/agent.sh stop" SIGINT SIGTERM
/opt/agent/bin/agent.sh start
while :
do
  sleep 1
done
