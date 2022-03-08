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