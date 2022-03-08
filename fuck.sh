#! /bin/bash
#! author: sheng
#! date: 2022-03-05

source ./tool.sh
source ./system.sh
source ./net.sh
source ./docker.sh

commands=(
    "01 系统版本信息 sys_info"
    "02 CPU信息 sys_info"
    "03 配置静态IP change_static_ip"
    "04 防火墙设置 sys_firewall"
    "05 安装Docker环境 install_docker"
    "06 防火墙设置 sys_firewall"
)

load_panel() {
    echo "===============FUCK 命令行=================="

    length=${#commands[@]}

    i=0
    while [ $i -lt $length ]; do
        # 字符串转数组，分隔符为空白符
        element=(${commands[$i]})

        if [[ $(expr $i % 2) -ne 0 ]]; then
            printf "(%s) %-30s\n" "${element[0]}" "${element[1]}"
            # echo "(${element[0]}) ${element[1]}  0000"
        else
            printf "(%s) %-30s" "${element[0]}" "${element[1]}"
        fi

        #按下标打印数组元素
        let i++
    done

    echo "============================================"
    echo -e "\nTIPS: 按下 <CTRL-D> 退出\n" # -e 开启转义
    echo -e "请输入命令编号：\c"               # \c 不换行
}

exec() {
    length=${#commands[@]}
    i=0
    while [ $i -lt $length ]; do
        # 字符串转数组，分隔符为空白符
        element=(${commands[$i]})

        if [[ $1 = "${element[0]}" ]]; then
            cmd="${element[2]}"
            break
        fi

        #按下标打印数组元素
        let i++
    done

    if [[ $i -le $length && -n "$cmd" ]]; then
        $cmd
        unset cmd
    else
        echo "未识别的编号：$1"
    fi
}

load_panel
while read number; do
    if [ -z "$number" ]; then
        continue
    fi
    if [ $number = "0" ]; then
        exit
    fi
    exec $number
    break
    load_panel
done
