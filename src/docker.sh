#! /bin/bash
#! author: sheng
#! date: 2022-03-08

install_docker() {
    VERSION=`cat /etc/redhat-release|grep '^CentOS [a-zA-Z ]* [7|8]$'`

    if [[ -z $VERSION ]]; then
        echo "当前的操作系统为：$(cat /etc/redhat-release), 本脚本仅支持 CentOS 7 or 8"
        return 1
    fi

    # 列出已安装的列表，是否存在历史版本
    yum list installed | grep docker

    if [[ $? -eq 0 ]]; then
        echo -e "\n已安装以上Docker版本, 安装前请先卸载。"
        return 1
    fi

    #yum install -y yum-utils
    #yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

    #echo "Docker版本列表: "
    #yum list docker-ce --showduplicates --available | sort -r | grep docker | awk '{print $2}'|awk -F '[:-]' '{print $2}'

    yum install docker-ce docker-ce-cli containerd.io -y
    if [[ $? -ne 0 ]]; then
       return 1
    fi

    systemctl start docker
    docker run hello-world
}