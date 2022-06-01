#!/bin/bash
# 
#********************************************************************
#Author: dddachui
#Date: 2022-06-01
#FileName： system_info.sh
#Description： Show system information
#Version: 0.2
#********************************************************************
check_centos(){
if [ -f "/etc/centos-release" ]; then
    OS=$(cat /etc/centos-release)
fi
}
check_kylinSec(){
if [ -f "/etc/.kyinfo" ]; then
    OS=$(cat /etc/.kyinfo  | grep dist_id | awk '{print $3}')
fi
}
RED="\E[1;31m"
GREEN="echo -e \E[1;32m"
END="\E[0m"
OS=null
check_centos
check_kylinSec
$GREEN----------------------主机信息采集--------------------$END
echo -e "主机名: $RED$(hostname)$END"
echo -e "系统版本: $RED${OS}$END"
echo -e "内核: $RED$(uname -r)$END"
echo -e "CPU型号: $RED$(cat /proc/cpuinfo | grep 'model name' | uniq | cut -d: -f2)$END"
echo -e "物理CPU数量: $RED$(cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l)$END"
echo -e "CPU的核心数: $RED$(cat /proc/cpuinfo| grep "cpu cores"| uniq |awk '{print $4}')$END"
echo -e "CPU的逻辑数: $RED$(cat /proc/cpuinfo| grep "processor"| wc -l)$END"
echo -e "显卡型号: $RED$(lspci -k |grep -i vga | awk '{print $5$8$9}')$END"
echo -e "实际可用内存: $RED$(free -h|grep Mem|tr -s ' ' : |cut -d : -f2)$END"
echo -e "物理内存容量： $RED$(dmidecode | grep -A16 "Memory Device$"|grep Size|grep -v No | awk '{sum+=$2}END{print sum}')M$END"
echo -e "内存条数量:  $RED$(dmidecode | grep -A16 "Memory Device$"|grep Size|grep -v No| wc -l)条$END"
echo -e "单根内存容量: \n $RED$(dmidecode | grep -A16 "Memory Device$"|grep Size|grep -v No)$END"
$GREEN---------------------------------------------------------$END