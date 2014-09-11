#!/bin/sh
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-7-1
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
#####################################################
# 输入文件
#####################################################
# 配置文件
CONF_FILE=$(basename $0 .sh).conf
# 判断对应文件是否存在,若存在则导入
[ -f $CONF_FILE ] && . $CONF_FILE
# 输入文件
CSV_FILE=PraseXmlByShell.csv
# 模板文件
XML_INPT=QueryExample.xml


#####################################################
# 过程文件
#####################################################
# 本文件输出日志文件名称
LOG_FILE=$(basename $0 .sh).log


#####################################################
# 输出文件
#####################################################
# 本文件名称
XML_FILE=$(basename $0 .sh).xml

. ./XmlMaker.sh

# yum -y install xmlstarlet

cat $CSV_FILE |
# + <query>
# +-- <name> 
# +-- <description> 
# +-- <comment> 
# +-- <oid_index> 
# +-- <index_order> 
# +-- <index_order_type> 
# +-- <index_title_format> 
# +-- <fields>
# +------- <diskIOIndex>
# +------- <name> 
# +------- <method> 
# +------- <source> 
# +------- <direction> 
# +------- <oid> 

. ./XmlMaker.sh
outfile=Output1.xml

put_head 'xml version='1.0' encoding="uft8"'
tag_start 'query'
tag_start 'name'
tag_substart 'description'
tag_substart 'comment'
tag_substart 'oid_index'
tag_substart 'index_order'
tag_substart 'index_order_type'
tag_substart 'index_title_format'
tag_substart 'fields'

tag_start 'query'
tag_start 'name'
tag_value '网卡' 1
tag_end '硬件'
tag_end '投递信息'