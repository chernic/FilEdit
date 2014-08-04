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
TEST_DIR=$LOCAL_PATH/TestFiles



# # 模拟场景一:# 失效Yum Repo中的epel库
# # 步骤1, 先查找 [epel] 所在行
# # 步骤2, 在修改第一个出现的 "enabled="
# # 步骤3, 赋值为1或者0
# REPO_DIR=/etc/yum.repos.d/
# REPO_DIR=$TEST_DIR
# ChangeRepo()
# {
	# # 找出指定行并修改
	# LOG_INFO "Change $1.repo enoD"
	# FILE=$REPO_DIR/$1.repo
	# lss=$1
	# ss=$(grep -n '^\['$lss'\]' $FILE | cut -d ':' -f 1)
	# sed -i $ss',/enabled/ s/enabled.*/enabled='$2'/' $FILE
	
	# LOG_INFO "Grep enabled from $1.repo"
	# grep 'enabled' $FILE	
	
	# LOG_INFO "Change $1.repo Done\n"
# }
# ChangeRepo "epel" "1";
# ChangeRepo "epel" "0";


# 模拟场景一:# 失效Yum Repo中的epel库
# 步骤1, 
# 步骤2, 
# 步骤3, 
REPO_DIR=
REPO_DIR=$TEST_DIR
DIRR="123"  
#"/usr/share/fonts/ukai.ttc"
ChangeRepo()
{
	# 找出指定行并修改
	LOG_INFO "Change $1 enoD"
		FILE=$REPO_DIR/$1
		LOG_INFO "File Found : $FILE"
		
		LOG_INFO "Edit Line $ss enoD"	
			ss=$(grep -n 'path_rrdtool_default_font' $FILE | cut -d ':' -f 1)
			# 重复method的格式
			sed -i $ss',/max_length/ s/^.*method.*$/&\n&/' $FILE
			sed -i $ss',/max_length/ O,/s/"method.*$/"default" =>'$DIRR'/' $FILE
		LOG_INFO "Edit Line $ss Done"

		LOG_INFO "Grep enabled from $1"
			sed -n '79,90p' $FILE	
	LOG_INFO "Change $1.repo Done\n"
}
ChangeRepo "global_settings.php" 