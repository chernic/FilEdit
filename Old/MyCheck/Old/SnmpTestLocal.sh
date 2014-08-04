#!/bin/sh
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-7-1
#####################################################
# Chernic's Report Head
LABLE3='\n\n### Cc@FS: '
LABLE2='\n## Cc@FS: '
LABLE1='# Cc@FS: '
#####################################################
BUILD_DIR=`pwd`
# [获取本文件路径 的 文件名称] 即本文件名的配置文件
CONF_FILE=$(basename $0 .sh).conf
# 判断对应文件是否存在,若存在则导入
[ -f $CONF_FILE ] && . $CONF_FILE


IPLocal=localhost
IPWindo=192.168.1.128
IPLinux=192.168.1.128

IPAddress=$IPLocal
echo -e $LABLE3"Start to Snmpwalk $IPAddress"

echo -e $LABLE2"Now Comes 1 minute Load"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.10.1.3.1 
echo -e $LABLE2"Now Comes 5 minute Load"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.10.1.3.2 
echo -e $LABLE2"Now Comes 15 minute Load"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.10.1.3.3 

echo -e $LABLE2"Now Comes percentage of user CPU time"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.11.9.0 
echo -e $LABLE2"Now Comes raw user cpu time"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.11.50.0 
echo -e $LABLE2"Now Comes percentages of system CPU time"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.11.10.0 
echo -e $LABLE2"Now Comes raw system cpu time"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.11.52.0 
echo -e $LABLE2"Now Comes percentages of idle CPU time"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.11.11.0 
echo -e $LABLE2"Now Comes raw idle cpu time"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.11.53.0 
echo -e $LABLE2"Now Comes raw nice cpu time"
snmpwalk -v2c -c public $IPAddress .1.3.6.1.4.1.2021.11.51.0 