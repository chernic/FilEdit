#!/bin/sh
#####################################################
# Version : 0.0.2
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-7-2
#####################################################
# This Shell Script has been Test on RHEL-5
# This Shell Script has benn Test in Static/DHCP Mode
#####################################################
# Chernic's Report Head
LABLE3='\n\n### Cc@FS: '
LABLE2='\n## Cc@FS: '
LABLE1='# Cc@FS: '
#####################################################
BUILD_DIR=`pwd`
# 文件名的配置文件
CONF_FILE=$(basename $0 .sh).conf
# 判断对应文件是否存在,若存在则导入
[ -f $CONF_FILE ] && . $CONF_FILE
# 本文件名称
OID=$(basename $0 .sh)
# 本文件输出日志文件名称
LOG=$(basename $0 .sh).log

name="Get Monitored Partitions"
oid_index=".1.3.6.1.4.1.2021.9.1.1"
index_order="dskDevice:dskIndex"
index_order_type="numeric"
index_title_format="|chosen_order_field|"