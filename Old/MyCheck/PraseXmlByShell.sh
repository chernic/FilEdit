#!/bin/sh
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-7-1
# More : http://stackoverflow.com/questions/893585/how-to-parse-xml-in-bash
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


# 输出操作指引
Usage()
{
	echo "Enter Like This: $0 <$XML_FILE>"
	exit 1
}
# 当没有输入参数时 输出操作指引
if [ $# -ne 1 ]
then
    Usage
fi

read_dom() {
	# 保存旧的标志位
	# If for some reason local IFS=\> doesn't work for you and you set it globally
	ORIGINAL_IFS=$IFS
	
	# 设置标志位为 \>
	# The first line makes IFS (the input field separator) local to this function and changes it to >. That means that when you read data instead of automatically being split on space, tab or newlines it gets split on '>'. 
    local IFS=\>
	# 根据标志位获取标签<ENTITY>和其内容<CONTENT>
	# The next line says to read input from stdin, and instead of stopping at a newline, stop when you see a '<' character (the -d for deliminator flag). What is read is then split using the IFS and assigned to the variable ENTITY and CONTENT. 
    read -d \< ENTITY CONTENT
	
	# 保存退出状态
	# For FreeBSD and suggested saving the exit status from read and
    local RET=$?
	
	# 利用Shell获取标签
	# To split out attribute name/value pairs
    TAG_NAME=${ENTITY%% *}
    ATTRIBUTES=${ENTITY#* }
	
	# 还原标志位
	# you should reset IFS at the end of the function
	IFS=$ORIGINAL_IFS
	
	# 返回值
	#  returning it at the end of read_dom
    return $RET
}


parse_dom () {
	# $ENTITY
	# $CONTENT
	# $TAG_NAME
	# $ATTRIBUTES
    if [[ $TAG_NAME = "oid" ]] ; then
        eval local $ATTRIBUTES
        echo "Oid = $CONTENT"
    fi
}

# 查找含有Key的标签,输出其内容
echo "#### Test 3"
while read_dom; do
    parse_dom
done < $1
