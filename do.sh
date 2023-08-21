#!/bin/bash  
sudo wget -qO- https://get.docker.com/ | bash
if [ $? -ne 0 ]; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
fi
docker --version





sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# remove all docker data 
sudo rm -rf /var/lib/docker

#  preinstall utils 
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# add repository
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# make cache
sudo yum makecache fast

# install the latest stable version of docker
sudo yum install -y docker-ce

# start deamon and enable auto start when power on
sudo systemctl start docker
sudo systemctl enable docker

# add current user 
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo systemctl restart docker





read -r -p "确认是Debioan吗? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
		apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt-get install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
curl -L https://get.daocloud.io/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
		;;
    [nN][oO]|[nN])
yum remove docker docker-engine docker.io containerd runc
yum update
yum install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
yum update
yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
curl -L https://get.daocloud.io/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
       	;;
    *)
		echo "Invalid input..."
		exit 1
		;;
esac
