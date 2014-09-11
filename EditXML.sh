#!/bin/sh
export PS4='+[$LINENO]'

BreakPoint()
{
    while [ "y" != "$AUTO_FLAG_yn" ]
    do
        read -p "\033[33mDo you Make Sure to Continue? [y/n/q] \033[0m" AUTO_FLAG_yn;
        [ "$AUTO_FLAG_yn" == "q" ] && exit 0;
    done
    AUTO_FLAG_yn="n"
}

NotRootOut()
{
    [ "0" != "$(id -u)" ] && echo "Error: You must be root to run this script" && exit 1 
}

GetIPAddress()
{
    IPAddress=`ifconfig eth0 | grep 'inet addr' | cut -d ":" -f 2 | cut -d " " -f 1`
}

ReadConf()
{
    # 全局配置实际路径
		LOCAL_PATH=$(dirname "$0");
    # 获取脚本同名配置
		CONF_FILE="$1"
    # 加载日志函数
    if [ -f $LOCAL_PATH/$CONF_FILE ];then
        echo -e "$CONF_FILE is \033[32mFound.\033[0m"
        source $LOCAL_PATH/$CONF_FILE
    else
        echo -e "$CONF_FILE is \033[31mNot Found.\033[0m"
    fi
}

NotRootOut;
ReadConf "Global.conf";
ReadConf "$(basename $0 .sh).conf";
ReadConf "log.sh";
LOG_INFO "Load Configures Done.\n"

############### Template Version 0.1.2 ##############
# *.XML Operating By xmlstarlet
#####################################################
# Version : 0.0.2
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-08-21
# Tool Needed : xmlstarlet
# v0.0.1(2014-08-04) : File Created

LOCAL_PATH=$(dirname $0)
TEST_IN=$LOCAL_PATH/TestFilesIn
TEST_OT=$LOCAL_PATH/TestFilesOut

LOG_WARN "Copy UnEdited File to Test enoD"
chmod -wx -R $TEST_IN
rm -vrf $TEST_OT
cp -vrf $TEST_IN $TEST_OT # EditXML.xml, acdserver.xml 
chmod +w -R $TEST_OT
LOG_WARN "Copy UnEdited File to Test Done\n"

XMLEditTest1()
{

	 which xmlstarlet && echo "xmlstarlet is OK" || yum -y install xmlstarlet
	# 删除节点
	xmlstarlet ed -d /query/name $TEST_OT/$(basename $0 .sh).xml
	# 移动节点
	xmlstarlet ed -m "//description" "//comment" $TEST_OT/$(basename $0 .sh).xml
	# 更改节点
	xmlstarlet ed -r "//*/description" -v ID   $TEST_OT/$(basename $0 .sh).xml
	# 更改节点结构
	xmlstarlet ed -r "//*/@description" -v ID   $TEST_OT/$(basename $0 .sh).xml
	# 前加节点
	xmlstarlet ed -i /query -t elem  -n nema -v value  $TEST_OT/$(basename $0 .sh).xml
	# 后加节点
	xmlstarlet ed -a /query -t elem  -n nema -v value  $TEST_OT/$(basename $0 .sh).xml
	# 加子节点
	xmlstarlet ed -s /query -t elem  -n nema -v value  $TEST_OT/$(basename $0 .sh).xml
	
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
	#cat $TEST_OT/$(basename $0 .sh).xml
}
# XMLEditTest1;

XMLEditTest2()
{
	xmlstarlet val $TEST_OT/acdserver.xml 
	xmlstarlet el $TEST_OT/acdserver.xml 
	# xmlstarlet sel -t -m "/system"  $TEST_OT/acdserver.xml 
	xmlstarlet sel -t -m "/system/NetBusIp" -v "."  $TEST_OT/acdserver.xml 
}


XMLEditTest2;

