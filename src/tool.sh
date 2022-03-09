#! /bin/bash
#! author: sheng
#! date: 2022-03-06


is_ipv4(){

    if [[ $1 =~ ^([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$ ]]
    then
        #echo "Match: ${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.${BASH_REMATCH[3]}.${BASH_REMATCH[4]}"
        return 0
    else
        #echo "Not match"
        return 1
    fi

}

# 读取用户的输入， 直至输入不为空
readn(){
    read INPUT
    while [ -z $INPUT ] # 输入为空
    do
        read INPUT
    done

    echo $INPUT
}