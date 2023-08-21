#!/bin/bash
if grep -Eqii "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
  DISTRO='CentOS'
  PM='yum'
  yum update
  yum upgrade
  yum install -y git make wget curl unzip vim
  yum install kde-l10n-Chinese
  yum reinstall glibc-common
  mv /etc/locale.conf /etc/locale.conf1
  cat>/etc/locale.conf<<EOF  
  LANG=zh_CN.UTF-8
  EOF
  source /etc/locale.conf
  read -r -p "输入新的主机名：" newname
  hostnamectl set-hostname $newname
  hostnamectl --static
  echo " PS1="\[\e[1;35m\]\A*\[\e[32;1m\]\h\[\e[1;35m\]\W>>>\[\e[0m\]"  " >> /etc/profile.d/env.sh
  source /etc/profile.d/env.sh
elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
    DISTRO='Debian'
    PM='apt'
    apt update
    apt upgrade
    apt install -y git make wget curl unzip vim
    apt-get install locales 
    dpkg-reconfigure locales 
    locale
    sudo echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen 
    dpkg-reconfigure locales 
    export LC_ALL="zh_CN.UTF-8"
    read -r -p "输入新的主机名：" newname
    hostnamectl set-hostname $newname
    hostnamectl --static
    echo " PS1="${debian_chroot:+($debian_chroot)}\[\e[1;35m\]\A*\[\e[32;1m\]\h\[\e[1;35m\]\W>>>\[\e[0m\]"  " >> ~/.bashrc
    source ~/.bashrc
elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    else
        DISTRO='unknow'
    fi
    echo $DISTRO;
}
Name
