#! /bin/bash
#! author: sheng
#! date: 2022-03-05

sys_info() {

    echo -e "\n\n\n ==========操作系统信息===============\n\n"
    echo "发行版本：$(cat /etc/redhat-release)"
    echo "内核版本：$(cat /proc/version)"
    echo " OS位数：$(getconf LONG_BIT)"

    echo -e "\n ====================================="
}

sys_firewall_cmd(){
    echo -e "\n\n\n ==========防火墙设置===============\n"
    echo "命令列表："
    echo -e " p  查看状态\n"
    echo " s  启动"
    echo " t  停止"
    echo -e " r  重启\n"
    echo " l  查看开放端口"
    echo -e " a  开放开放端口"
    echo -e " rm  移除开放端口\n"

    echo -e " q  退出\n"

     echo -e "选择命令: \c"

}

sys_firewall_exec(){
    case $1 in
        "p") echo "$(firewall-cmd --state)"
        return $?
        ;;
        "s") echo "$(systemctl start firewalld)"
        return $?
        ;;
        "t") echo "$(systemctl stop firewalld)"
        return $?
        ;;
        "r") echo "$(systemctl reload firewalld)"
        return $?
        ;;
        "l") echo "$(firewall-cmd --list-ports)"
        return $?
        ;;
    esac

    if [[ $1 = "a" ]]; then

        echo -e "输入要开放的端口 [1-65535]: \c"
        P=$(readn)

        if [[ $P -gt 0 && $p -le 65535 ]]; then
            echo "端口输入: $P"
        else
            echo "无效的端口输入: $P"
            return 1
        fi

        read -p "输入端口协议 [tcp or udp, default tcp]: " TCP
        
        if [[ -z $TCP ]]; then
            TCP="tcp"
        fi

        if [[ $TCP != "tcp" && $TCP != "udp" ]]; then
            echo "无效的输入: $TCP"
            return 1
        else
            echo "TCP: $TCP"
        fi

        firewall-cmd --zone=public --add-port=$P/$TCP --permanent
        firewall-cmd --reload

        return $?
    fi

    if [[ $1 = "rm" ]]; then

        echo -e "输入要移除的端口 [1-65535]: \c"
        P=$(readn)

        if [[ $P -gt 0 && $p -le 65535 ]]; then
            echo "端口输入: $P"
        else
            echo "无效的端口输入: $P"
            return 1
        fi

        read -p "输入端口协议 [tcp or udp, default tcp]: " TCP
        
        if [[ -z $TCP ]]; then
            TCP="tcp"
        fi

        if [[ $TCP != "tcp" && $TCP != "udp" ]]; then
            echo "无效的输入: $TCP"
            return 1
        else
            echo "TCP: $TCP"
        fi

        firewall-cmd --zone=public --remove-port=$P/$TCP --permanent
        firewall-cmd --reload

        return $?
    fi

    echo  "无效的命令：$1"
}

sys_firewall() {
    sys_firewall_cmd
    CMD=$(readn)
    if [[ $CMD != "q" ]]; then
        sys_firewall_exec $CMD
    fi
}