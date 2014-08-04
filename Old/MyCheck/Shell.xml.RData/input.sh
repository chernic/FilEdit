#!/bin/sh
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-7-1
# More : http://stackoverflow.com/questions/893585/how-to-parse-xml-in-bash
#####################################################


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
	
	# For FreeBSD and suggested saving the exit status from read and
    local RET=$?
	
	# 利用Shell获取标签
	# To split out attribute name/value pairs
    TAG_NAME=${ENTITY%% *}
    ATTRIBUTES=${ENTITY#* }
	
	# 还原标志位
	# you should reset IFS at the end of the function
	IFS=$ORIGINAL_IFS
	
	#  returning it at the end of read_dom
    return $RET
}



# 遍历整个XML,逐一输出标签和内容
echo "#### Test 1"
while read_dom; do
    echo "$ENTITY => $CONTENT"
done < input.xml

# 查找含有Key的标签,输出其内容
echo "#### Test 2"
while read_dom; do
    if [[ $ENTITY = "Key" ]] ; then
        echo $CONTENT
    fi
done < input.xml


parse_dom () {
    if [[ $TAG_NAME = "foo" ]] ; then
        eval local $ATTRIBUTES
        echo "foo size is: $size"
    elif [[ $TAG_NAME = "bar" ]] ; then
        eval local $ATTRIBUTES
        echo "bar type is: $type"
    fi
}
# 查找含有Key的标签,输出其内容
echo "#### Test 3"
while read_dom; do
    parse_dom
done < input.xml


