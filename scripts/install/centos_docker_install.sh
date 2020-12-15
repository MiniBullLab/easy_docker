#!/bin/bash
#docker-ce
uname -r
sudo yum update
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum list docker-ce --showduplicates | sort -r
sudo yum install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo systemctl enable docker

# add user
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
newgrp docker

docker version
systemctl enable docker    # 设置开机启动
systemctl start docker    # 启动docker
systemctl status docker   # 查看状态

#nvidia-docker
sudo yum remove nvidia-docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | \
  sudo tee /etc/yum.repos.d/nvidia-docker.repo
DIST=$(sed -n 's/releasever=//p' /etc/yum.conf)
DIST=${DIST:-$(. /etc/os-release; echo $VERSION_ID)}
sudo yum -y makecache
sudo yum install -y nvidia-docker2
sudo pkill -SIGHUP dockerd

#nvidia-docker register
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host=fd:// --add-runtime=nvidia=/usr/bin/nvidia-container-runtime
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

Daemon configuration file

sudo tee /etc/docker/daemon.json <<EOF
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
EOF
sudo pkill -SIGHUP dockerd

