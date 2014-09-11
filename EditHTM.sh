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
# MD5 html 头部校检替换
#####################################################
# Version : 0.0.2
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-08-21
# v0.0.1(2014-08-04) : File Created
# v0.0.2(2014-08-04) : File Created
LOCAL_PATH=$(dirname $0)
TEST_IN=$LOCAL_PATH/TestFilesIn
TEST_OT=$LOCAL_PATH/TestFilesOut

LOG_WARN "Copy UnEdited File to Test enoD"
chmod -wx -R $TEST_IN
rm -vrf $TEST_OT
cp -vrf $TEST_IN $TEST_OT
chmod +w -R $TEST_OT
LOG_WARN "Copy UnEdited File to Test Done\n"


HtmAddHead()
{
	cd $LOCAL_PATH
	[ -d tmp ] || mkdir tmp
	
	HeadFlag="<!-- The End of Head -->"
	HeadFile="$LOCAL_PATH/tmp/HeadFile.htm"
	HeadMD5="$LOCAL_PATH/tmp/HeadFile.md5"

	TailFlag="<!-- The End of Tail-->"
	TailFile="$LOCAL_PATH/tmp/TailFile.htm"
	TailMD5="$LOCAL_PATH/tmp/TailFile.md5"

	awk "!i++, /$HeadFlag/" $TEST_OT/ListX > $HeadFile
	md5sum $HeadFile > $HeadMD5
	OriMd5=$(cut -d ' ' -f1 $HeadMD5)
	# awk "!i++, /$HeadFlag/" ListX | md5sum | cut -d ' ' -f1
	
	for i in $(find . -name "List*.htm")
	do
		LastLine=$(grep -n "$HeadFlag" $i | cut  -d  ":"  -f  1 | tail -1)
		TmpMd5=$(awk "!i++, /$HeadFlag/" $i | md5sum | cut -d ' ' -f1)
		echo "  OriMd5: $OriMd5"
		echo "  TmpMd5: $TmpMd5"
		sed -i "/^[[:space:]]*$/d" $i
		if [ ! $OriMd5 == $TmpMd5 ];then
			echo "Check 1:$LastLine Happy That Our FileHead Update ^-^"
			sed -i "1,$LastLine d" $i
			sed -i "
			1{
				x
				r $HeadFile
			}
			2{
				H
				x
			}
			" $i
		else
			echo "Check 1:$LastLine $HeadFile is the Same As $i"
		fi
	done
	
	LOG_INFO "Grep <12 to 14 > from $TEST_IN{ListX, List0_MethodNew.htm}"
		sed -n '12,14p' $TEST_IN/ListX
		sed -n '12,14p' $TEST_IN/List0_MethodNew.htm
	LOG_INFO "Grep <12 to 14 > from $TEST_OT{ListX, List0_MethodNew.htm}"
		sed -n '12,14p' $TEST_OT/ListX
		sed -n '12,14p' $TEST_OT/List0_MethodNew.htm
}

HtmAddHead;