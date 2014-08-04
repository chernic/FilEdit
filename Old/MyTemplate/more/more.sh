#!/bin/sh
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-7-1
# while :; do :; done
# Tool Needed : xmlstarlet
#####################################################
# 打印头 / 宏
#####################################################
LABLE3='\n\n### Cc@FS: '
LABLE2='\n## Cc@FS: '
LABLE1='# Cc@FS: '
BUILD_DIR=`pwd`
# 本文件名称
FILE_NAME=$(basename $0 .sh)
# 配置文件
CONF_FILE=$(basename $0 .sh).conf
# 判断对应文件是否存在,若存在则导入
[ -f $CONF_FILE ] && . $CONF_FILE

cd .
wget http://docs.cacti.net/_media/plugin:thold-v0.5.0.tgz
mv plugin:thold-v0.5.0.tgz thold-v0.5.0.tgz
cp thold-v0.5.0.tgz /home/wwwroot/default/cacti/plugin/

cd /home/wwwroot/default/cacti/plugin/
# mv ./thold ./tholdbak
tar zxvf thold-v0.5.0.tgz

cd ./thold
ls -l