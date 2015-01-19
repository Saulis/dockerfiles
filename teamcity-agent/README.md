#Usage
```bash
wget https://raw.githubusercontent.com/Saulis/dockerfiles/master/teamcity-agent/Dockerfile
wget https://raw.githubusercontent.com/Saulis/dockerfiles/master/teamcity-agent/start.sh

# CoreOS
docker build -t teamcity-agent .
mkdir /home/core/work
docker create -v /home/core/work/:/opt/agent/work --net="host" --name="agent" -t teamcity-agent
# this is to control container from systemd
sudo vim /etc/systemd/system/agent.service
sudo systemctl enable agent.service
sudo systemctl start agent.service

# Ubuntu Trusty
curl -sSL https://get.docker.com/ubuntu/ | sudo sh
sudo docker build -t teamcity-agent .
mkdir /home/ubuntu/work
sudo docker create -v /home/ubuntu/work/:/opt/agent/work --net="host" --restart="always" --name="agent" -t teamcity-agent
sudo docker start agent

```

agent.service:
```
[Unit]
Description=docker startup
After=network-online.target
Requires=network-online.target

[Service]
ExecStart=/usr/bin/docker start -a agent
ExecStop=/usr/bin/docker stop -t 5 agent

[Install]
WantedBy=multi-user.target
```
