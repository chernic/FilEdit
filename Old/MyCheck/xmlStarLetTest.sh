#!/bin/sh
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-7-1
# Tool Needed : xmlstarlet
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
OID_FILE=$(basename $0 .sh)
# 本文件名称
XML_FILE=$(basename $0 .sh).xml
#
NEW_FILE=test.csv
# 本文件输出日志文件名称
LOG_FILE=$(basename $0 .sh).log
# 临时tmp.sh
TMP_FILE=$(basename $0 .sh).sql


# yum -y install xmlstarlet
# 删除节点
xmlstarlet ed -d /query/name test.xml
# 移动节点
xmlstarlet ed -m "//description" "//comment" test.xml
# 更改节点
xmlstarlet ed -r "//*/description" -v ID   test.xml
# 更改节点结构
xmlstarlet ed -r "//*/@description" -v ID   test.xml
# 前加节点
xmlstarlet ed -i /query -t elem  -n nema -v value  test.xml
# 后加节点
xmlstarlet ed -a /query -t elem  -n nema -v value  test.xml
# 加子节点
xmlstarlet ed -s /query -t elem  -n nema -v value  test.xml



# # Example5:（更改所有aaa的值）
# #-u 是update  -v 是value
# echo -e $LABLE2"Prase all tag of aaa"
# xmlstarlet ed -u /root/aaa -v 123 test.xml > New.xml
# # Example6:（更改第二个aaa的值）
# # -d 是delete
# echo -e $LABLE2"Prase 2ed tag of aaa"
# xmlstarlet ed -d /root/aaa[2] test.xml

# # yum -y install xmlstarlet
# # 删除节点
# echo -e $LABLE2"Delete"
# xmlstarlet ed -d /root/aaa test.xml

# # 移动节点
# echo -e $LABLE2"Move"
# xmlstarlet ed -m "//aaa" "//comment" test.xml

# # 更改节点
# echo -e $LABLE2"Rename"
# xmlstarlet ed -r "//*/aaa" -v NewElem   test.xml

# # 更改节点结构
# echo -e $LABLE2"Rename attr"
# xmlstarlet ed -r "//*/@OldID" -v NewAttr   test.xml

# # 前加节点
# echo -e $LABLE2"Add Before"
# xmlstarlet ed -i /root -t elem  -n Newname -v " **** "  test.xml

# # 后加节点
# echo -e $LABLE2"Add After"
# xmlstarlet ed -a /root -t elem  -n Newname -v " **** "  test.xml

# # 加子节点
# echo -e $LABLE2"Add As Sub"
# xmlstarlet ed -s /root -t elem  -n Newname -v " **** "  test.xml

# Example7:（验证XML文件）
# -d 是delete
# echo -e $LABLE2"Test test.xml"
# xmlstarlet val test.xml