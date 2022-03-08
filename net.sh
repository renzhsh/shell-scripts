#! /bin/bash
#! author: sheng
#! date: 2022-03-06

change_static_ip(){

    echo -e "\n\n===============变更静态IP=====================\n\n"

    CONFDIR=/etc/sysconfig/network-scripts/

    echo -e "network dev list:"

    ls -l "$CONFDIR" | grep ifcfg | grep -v bak |awk '{print $9}' | awk -F- '{print $2}'


    echo -e "\nselect the dev: \c"

    ENS=$(readn)

    FILE="${CONFDIR}ifcfg-$ENS"

    if [ ! -e $FILE ]; then
        echo "不存在的网卡$ENS, 请重新设置！！"
        return
    fi

    echo -e "input the ipv4 address: \c"

    while true
    do
        IP=$(readn)
        is_ipv4 $IP # 是否是有效的IP

        if [ $? -eq 0 ]; then 
            break
        else
            echo "invalid ip: $IP"
            echo -e "input the ipv4 address again: \c"
        fi
    done

    read -p "input the gateway [192.168.1.1]: " GATEWAY

    while true
    do
        if [ -z $GATEWAY ]; then
            GATEWAY="192.168.1.1"
        fi
        is_ipv4 $GATEWAY # 是否是有效的IP
        if [ $? -eq 0 ]; then 
            break
        else
            echo "invalid gateway: $GATEWAY"
            read -p "input the gateway again [192.168.1.1]: " GATEWAY
        fi
    done

    read -p "input the netmask [255.255.255.0]: " NETMASK

    while true
    do
        if [ -z $NETMASK ]; then
            NETMASK="255.255.255.0"
        fi
        is_ipv4 $NETMASK # 是否是有效的IP
        if [ $? -eq 0 ]; then 
            break
        else
            echo "invalid netmask: $NETMASK"
            read -p "input the netmask again [255.255.255.0]: " NETMASK
        fi
    done


    #sed -e 可以连续修改多个参数# 
    sed -i -e 's/dhcp/static/g' -e 's/^ONBOOT/#ONBOOT/g' -e 's/^IPADDR/#IPADDR/g' -e 's/^PREFIX/#PREFIX/g' -e 's/^NETMASK/#NETMASK/g' -e 's/^GATEWAY/#GATEWAY/g' $FILE

    echo -e "ONBOOT=yes\nIPADDR=$IP\nPREFIX=24\nNETMASK=$NETMASK\nGATEWAY=$GATEWAY\n" >>$FILE

    echo -e "\n\nThis IP address Change success ! Please reboot the server\n"

    echo "config: $FILE"
    echo "ipv4: $IP"
    echo "netmask: $NETMASK"
    echo -e "gateway: $GATEWAY\n\n"
}