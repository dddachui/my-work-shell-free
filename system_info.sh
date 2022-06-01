#!/bin/bash
# 
#********************************************************************
#Author: dddachui
#Date: 2022-06-01
#FileName： systeminfo.sh
#Description： Show system information
#********************************************************************
RED="\E[1;31m"
GREEN="echo -e \E[1;32m"
END="\E[0m"
$GREEN----------------------主机信息采集--------------------$END
echo -e "主机名: $RED$(hostname)$END"
#echo -e "IPADDR: $RED` ifconfig eth0|grep -Eo '([0-9]{1,3}\.){3}[0-9]
#{1,3}' |head -n1`$END"
echo -e "系统版本: $RED$(cat /etc/.kyinfo  | grep dist_id | awk '{print $3}')$END"
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
#echo -e "DISK: $RED`lsblk |grep '^sd' |tr -s ' ' |cut -d " " -f4`$END"
$GREEN---------------------------------------------------------$END
