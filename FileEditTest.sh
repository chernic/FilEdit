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
	# 获取脚本同名配置
	CONF_FILE=$(basename $0 .sh).conf
	# 加载日志函数
	if [ -f $CONF_FILE ];then
		. $CONF_FILE
		echo -e "Configure is \033[32mFound.\033[0m"
	else
		echo -e "Configure is \033[32mNot Found.\033[0m"
	fi
}

ReadLogf()
{
	if [ -z $LOG_IS_NEEDED ]; then
	# 日志脚本实际路径
	  LOCAL_PATH=$(dirname "$0");
	# 加载日志函数
	  source "${LOCAL_PATH}/log.sh";
	fi
}

NotRootOut;
ReadConf
ReadLogf;
LOG_INFO "Load Configure Done.\n"

############### Template Version 0.1.0 ##############
#####################################################
# File Edit Functions
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-08-04
# v0.0.1(2014-08-04) : File Created
TEST_IN=$LOCAL_PATH/TestFilesIn
TEST_OT=$LOCAL_PATH/TestFilesOut


LOG_WARN "Copy UnEdited File to Test enoD"
chmod -wx -R $TEST_IN
rm -vrf $TEST_OT
cp -vrf $TEST_IN $TEST_OT
chmod +w -R $TEST_OT
LOG_WARN "Copy UnEdited File to Test Done\n"

ChangeRepo1()
{
LOG_ERROR "Edit Test 1"
# 模拟场景一:# 失效Yum Repo 中的 epel 库
# 步骤1, 先查找 [epel] 所在行
# 步骤2, 在修改第一个出现的 "enabled="
# 步骤3, 赋值为1或者0
REPO_DIR=/etc/yum.repos.d/
REPO_DIR=$TEST_OT
	# 找出指定行并修改
	LOG_INFO "Change $1.repo enoD"
		FILE=$REPO_DIR/$1.repo
		lss=$1
		ss=$(grep -n '^\['$lss'\]' $FILE | cut -d ':' -f 1)
		sed -i $ss',/enabled/ s/enabled.*/enabled='$2'/' $FILE
		
		LOG_INFO "Grep enabled from $1.repo"
		grep -n 'enabled' $FILE	
	
	LOG_INFO "Change $1.repo Done\n"
}
ChangeRepo1 "epel" "0";
ChangeRepo1 "epel" "1";

ChangePHP2_0()
{
LOG_ERROR "Edit Test 2.0"
# 模拟场景二:# 为 PHP 文件的数组变量 增添 子元素(原始版)
# 步骤1, 定位字符串,找到首字段所在行
# 步骤2, 模拟原字符串格式,复制字符串 直到尾字段
# 步骤3, 修改符合格式的字符串的内容  直到尾字段
PHP_DIR=$CACTI_LINK/include/global_settings.php
PHP_DIR=$TEST_OT
DIRR="/usr/share/fonts/ukai.ttc"
	# 找出指定行并修改
	LOG_INFO "Change $1 enoD"
		FILE=$1
		LOG_INFO "  Found : $FILE"
		
		LOG_INFO "  Edit  : Line $ss enoD"
			# 定位 path_rrdtool_default_font 段到 max_length 段的字符串
			ss=$(grep -n 'path_rrdtool_default_font' $FILE | cut -d ':' -f 1)
			# 重复 max_length 段的格式
			sed -i $ss',/max_length/ s/^.*max_length.*$/&\n&/' $FILE
			# 修改 新增的 max_length 段
			sed -i $ss',/max_length/ s:"max_length.*$:"default" => "'$DIRR'",:' $FILE
		LOG_INFO "  Edit  : Line $ss Done\n"

		LOG_INFO "  Grep  : enabled from $1"
			sed -n '79,90p' $FILE	
	LOG_INFO "Change $1 Done.\n"
}
ChangePHP2_0 "$TEST_OT/global_settings.php" 

