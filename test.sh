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
CACTI_LINK="/var/www/html/cacticn/"

#touch new
cat > ./new  <<EOF
bin
passive
set confirm-close no
lcd /etc/snmp
cd $CACTI_LINK
put $FILE_NAME
passive
quit
EOF











