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
# Version : 0.2.4
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-08-04
# v0.0.1(2014-08-04) : File Created
# v0.2.4(2014-08-05) : ChangeRepo1() ChangePHP2_0() ChangePHP2_2() ChangePHP2_3() ChangePHP2_4() Added.
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
	# v0.0.2(2014-08-04) : 修改LOG以及报错信息
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
}
# ChangeRepo1 "epel" "0";
# ChangeRepo1 "epel" "1";

ChangePHP2_0()
{
	LOG_ERROR "Edit Test 2.0"
	# 模拟场景二:# 为 PHP 文件的数组变量 增添 子元素(原始版)
	# 步骤1, 定位字符串,找到首字段所在行
	# 步骤2, 模拟原字符串格式,复制字符串 直到尾字段
	# 步骤3, 修改符合格式的字符串的内容  直到尾字段
	# v0.0.2(2014-08-04) : 修改LOG以及报错信息
	PHP_DIR=$CACTI_LINK/include/global_settings.php
	PHP_DIR=$TEST_OT
	DIRR="/usr/share/fonts/ukai.ttc"
	FILE=$1
	
	LOG_INFO "Found : $FILE"
		# 定位 path_rrdtool_default_font 段到 max_length 段的字符串
		ss=$(grep -n 'path_rrdtool_default_font' $FILE | cut -d ':' -f 1)
	
	LOG_WARN "Edit Line $ss"
		# 重复 max_length 段的格式
		sed -i $ss',/max_length/ s/^.*max_length.*$/&\n&/' $FILE
		# 修改 新增的 max_length 段
		sed -i $ss',/max_length/ s:"max_length.*$:"default" => "'$DIRR'",:' $FILE

	LOG_INFO "Grep <79 to 90 > from $1"
		sed -n '79,90p' $FILE	
}
# ChangePHP2_0 "$TEST_OT/global_settings.php" 

ChangePHP2_1()
{
	LOG_ERROR "Edit Test 2.1"
	# 模拟场景二:# 为 PHP 文件的数组变量 增添 子元素(中插法，不能保证max_length存在)
	# 步骤1, 定位字符串,找到首字段所在行
	# 步骤2, 模拟原字符串格式,复制字符串 直到尾字段
	# 步骤3, 修改符合格式的字符串的内容  直到尾字段
	# v0.0.2(2014-08-04) : 修改LOG以及报错信息
	PHP_DIR=$CACTI_LINK/include/global_settings.php
	FILE=$1     # "$PHP_DIR/global_settings.php"
	BEGIN=$2    # "path_rrdtool_default_font"
	ENDIN=$3    # "max_length"
	CONTENT=$4  # "/usr/share/fonts/ukai.ttc"
	
	LOG_INFO "Found : $FILE"
	# 定位 path_rrdtool_default_font 段到 max_length 段的字符串
	ss=$(grep -n $BEGIN $FILE | cut -d ':' -f 1)
	
	LOG_WARN "Edit Line $ss"
		# 重复 max_length 段的格式
		sed -i $ss',/'$ENDIN'/ s/^.*'$ENDIN'.*$/&\n&/' $FILE
		# 修改 新增的 max_length 段
		sed -i $ss',/'$ENDIN'/ s:"'$ENDIN'.*$:"default" => "'$CONTENT'",:' $FILE
		
	LOG_INFO "Grep < $ss to $ENDFLAG > from $1"
		sed -n '79,90p' $FILE	
}
# ChangePHP2_1 "$TEST_OT/global_settings.php"  "path_rrdtool_default_font"  "max_length"  "/usr/share/fonts/ukai.ttc"

ChangePHP2_3()
{
	LOG_ERROR "Edit Test 2.3"
	# 模拟场景二:# 为 PHP 文件的数组变量 增添 子元素(尾插法：不完善“，”处理的不好)
	# 步骤1, 定位字符串,找到首字段所在行
	# 步骤2, 模拟原字符串格式,复制字符串 直到尾字段“）”
	# 步骤3, 修改符合格式的字符串的内容  直到尾字段“）”
	# v0.0.2(2014-08-04) : 修改LOG以及报错信息
	PHP_DIR=$CACTI_LINK/include/global_settings.php
	FILE=$1     # "$PHP_DIR/global_settings.php"
	BEGIN=$2    # "path_rrdtool_default_font"
	NEWADD=$3   # "default"
	CONTENT=$4  # "/usr/share/fonts/ukai.ttc"
	
	LOG_INFO "Found : $FILE"
		# 定位 path_rrdtool_default_font 段到 max_length 段的字符串
		ss=$(grep -n $BEGIN $FILE | cut -d ':' -f 1)
		
	LOG_WARN "Edit Line $ss"
		# 判断 default 段是否存在
		ct="`sed -n $ss',/)/  s:"'$NEWADD'".*$:&:p' $FILE`"
		if [ -z "$ct" ]; then
			echo "<$NEWADD> Not Exited."
			# 重复 max_length 段的格式
			sed -i $ss',/)/ s/^.*).*$/&,\n&/' $FILE                      # 非尾有逗号
			# 新增 default 段
			sed -i $ss',/)/ s:).*$:,"'$NEWADD'" => "'$CONTENT'":' $FILE  # 末尾无逗号
		else
			echo "<$NEWADD> Exited."
			sed -i $ss',/)/ s:'$NEWADD'.*$:,"'$NEWADD'" => "'$CONTENT'":' $FILE  # 末尾无逗号
		fi

	LOG_INFO "Grep < $BEGIN to ) > from $1"
		sed -n '/$BEGIN/,/)/p' $FILE	
}
# ChangePHP2_3 "$TEST_OT/global_settings.php"  "path_rrdtool_default_font"  "default"  "/usr/share/fonts/ukai.ttc"

ChangePHP2_4()
{
	LOG_ERROR "Edit Test 2.4.1"
	# 模拟场景二:# 为 PHP 文件的数组变量 增添 子元素(前插法)
	# 步骤1, 定位字符串,找到首字段所在行
	# 步骤2, 判断新增字段是否存在
	# 步骤3.1, 不存在则以 \"method\" <恒存在>为母版，在其上修改为新增字段
	# 步骤3.2, 存在则直接修改该字段
	# v0.0.1(2014-08-04) : 兼容 ")," 或 ");" 并可自定义
	# v0.0.2(2014-08-04) : 修改LOG以及报错信息
	PHP_DIR=$CACTI_LINK/include/global_settings.php
	FILE=$1       # "$PHP_DIR/global_settings.php"
	BEGIN=$2      # "path_rrdtool_default_font"
	NEWADD=$3     # "default"
	CONTENT=$4    # "/usr/share/fonts/ukai.ttc"
	[ -z $5 ] && ENDFLAG='),' || ENDFLAG=$5             # "This can be ), Or ); at the end."
	
	LOG_INFO "Found : $FILE"
		# 定位 path_rrdtool_default_font 段到 max_length 段的字符串
		ss=$(grep -n \"$BEGIN\" $FILE | cut -d ':' -f 1)
		
	LOG_WARN "Edit Line $ss"
		# 判断 "default" 段是否存在(假如重复会出错)
		ct="`sed -n $ss',/'$ENDFLAG'/  s:"'$NEWADD'".*$:&:p' $FILE`"
		if [ -z "$ct" ]; then
			echo "\"$BEGIN\" <\"$NEWADD\"> Not Exited. Insert it."
			# 重复 \"method\" 段的格式
			sed -i $ss',/'$ENDFLAG'/ s/^.*\"method\".*$/&,\n&/' $FILE                            # 非尾有逗号
			# 基于 method 段新增 $NEWADD 段
			sed -i $ss',/\"method\"/ s:\"method\".*$:\"'$NEWADD'\" => \"'$CONTENT'\",:' $FILE    # 末尾无逗号
		else
			echo "\"$BEGIN\" <\"$NEWADD\"> Exited. Change it."
			# 直接修改原有 \"'$NEWADD'\" 段
			sed -i $ss',/'$ENDFLAG'/ s:\"'$NEWADD'\".*$:\"'$NEWADD'\" => \"'$CONTENT'\",:' $FILE # 末尾无逗号
		fi

	LOG_INFO "Grep < $ss to $ENDFLAG > from $1"
		sed -n $ss',/'$ENDFLAG'/p' $FILE	
}
# ChangePHP2_4 "$TEST_OT/global_settings.php"  "path_rrdtool_default_font"  "default"      "/usr/share/fonts/ukai.ttc"
# ChangePHP2_4 "$TEST_OT/global_settings.php"  "path_rrdtool_default_font"  "description"  "描述已存在，直接修改"
# ChangePHP2_4 "$TEST_OT/global_settings.php"  "snmp_ver"                   "default"      "2"

ChangePHP2_5()
{
LOG_ERROR "Edit Test 2.5.2"
# 模拟场景二:# 为 PHP 文件的数组变量 增添 子元素(前插法 完善版)
# 步骤1, 定位字符串,找到首字段所在行
# 步骤2, 判断新增字段是否存在
# 步骤3.1, 不存在则以 \"method\" <恒存在>为母版，在其上修改为新增字段
# 步骤3.2, 存在则直接修改该字段
# v0.0.1(2014-08-04) : 兼容 ")," 或 ");" 并可自定义
# v0.0.2(2014-08-04) : 重复项(只须限定范围,范围本身不可重复)
PHP_DIR=$CACTI_LINK/include/global_settings.php
	FILE=$1       # "$PHP_DIR/global_settings.php"
	BEGIN=$2      # "path_rrdtool_default_font"
	NEWADD=$3     # "default"
	CONTENT=$4    # "/usr/share/fonts/ukai.ttc"
	[ -z $5 ] && ENDFLAG='),' || ENDFLAG=$5             # This can be ), Or );
	[ -z $6 ] && WHERESTART='<?php' || WHERESTART=$6	# What $BEGIN Should Start Searching
    [ -z $7 ] && WHEREEND='?>' || WHEREEND=$7           # What $BEGIN Should Stop  Searching
	
	LOG_INFO "Found : $FILE"
		# 定位 WHERESTART 段起 WHEREEND 段结束的 $BEGIN => array( 段
		ss=`sed -n '/'$WHERESTART'/,/'$WHEREEND'/{
		/\"'$BEGIN'\" => array(/{
		=
		}
		}' $FILE `
		
	LOG_WARN "Edit Line $ss"
		# 判断 "default" 段是否存在(假如重复会出错)
		ct="`sed -n $ss',/'$ENDFLAG'/  s:"'$NEWADD'".*$:&:p' $FILE`"
		if [ -z "$ct" ]; then
			echo "\"$BEGIN\" <\"$NEWADD\"> Not Exited. Insert it."
			# 重复 \"method\" 段的格式
			sed -i $ss',/'$ENDFLAG'/ s/^.*\"method\".*$/&,\n&/' $FILE                            # 非尾有逗号
			# 基于 method 段新增 $NEWADD 段
			sed -i $ss',/\"method\"/ s:\"method\".*$:\"'$NEWADD'\" => \"'$CONTENT'\",:' $FILE    # 末尾无逗号
		else
			echo "\"$BEGIN\" <\"$NEWADD\"> Exited. Change it."
			# 直接修改原有 \"'$NEWADD'\" 段
			sed -i $ss',/'$ENDFLAG'/ s:\"'$NEWADD'\".*$:\"'$NEWADD'\" => \"'$CONTENT'\",:' $FILE # 末尾无逗号
		fi

	LOG_INFO "Grep < $ss to $ENDFLAG > from $1"
		sed -n $ss',/'$ENDFLAG'/p' $FILE	
}
# ChangePHP2_4 "$TEST_OT/global_settings.php"  "path_rrdtool_default_font"  "description"  "描述已存在，直接修改"
# ChangePHP2_4 "$TEST_OT/global_settings.php"  "snmp_ver"                   "default"      "直接插入"
# ChangePHP2_5 "$TEST_OT/global_settings.php"  "unit_font"  "default"  "重复的尾数组元素也兼容"   ');'  "settings_graphs"


# sed -n '/INSERT INTO `host` VALUES/{
# s/\([^,]*\).*/\1/p
# }' ./TestFilesOut/cacti.sql

# sed ' s@\([^:]*\):\([^:]*\):\([^:]*\)@\3:\2:\1@g' /etc/passwd

# sed -i '/INSERT INTO `host` VALUES/{
# s@\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)@\1,\2,\3,\4,\5,\6, 2@
# }' ./TestFilesOut/cacti.sql



SqlConf3_1()
{
LOG_ERROR "Edit Test 3.1"
# 模拟场景二: 修改MySQL语句中的变量(不大于10行)
# 步骤1, 定位字符串,找到首字段所在行
# 步骤2, 判断新增字段是否存在
# 步骤3.1, 不存在则以 \"method\" <恒存在>为母版，在其上修改为新增字段
# 步骤3.2, 存在则直接修改该字段
# v0.0.1(2014-08-04) : 兼容 ")," 或 ");" 并可自定义
# v0.0.2(2014-08-04) : 重复项(只须限定范围,范围本身不可重复)
	FILE=$1       # 文件名称
	START=$2      # 开始标志
	ADDFLG=$3     # 分割标志
	CONTENT=$4    # 更改内容
	ADDWHERE=$5   # 第几段内容
	
	LOG_INFO "Found : $FILE"
		TARGET='\([^'$ADDFLG']*\)'$ADDFLG
		# 自增长的正则表达式
		for((i=1;i<=$ADDWHERE;i++));
		do 
			TARGET=$TARGET'\([^'$ADDFLG']*\)'$ADDFLG
			BEFORE=$BEFORE'\'$i','
		done
		# echo $TARGET # TARGET='\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),'
		# echo $BEFORE # BEFORE='\1,\2,\3,\4,\5,\6,'
		
	LOG_WARN "Edit Line of $START"
		# 包含正则表达式的分段查找替换
		sed -i "/$START/{
		s@$TARGET@$BEFORE $CONTENT,@
		}" $FILE
		# sed -i '/INSERT INTO `host` VALUES/{
		# s@'$TARGET'@'$BEFORE' '$CONTENT',@
		# }' $FILE

	LOG_INFO "Grep < $ss to $ENDFLAG > from $1"
		sed -n "/$START/p" $FILE
} 
# SqlConf3_1 "./TestFilesOut/cacti.sql"  "INSERT INTO \`host\` VALUES"  ","  2  6 
# sed -n '1888,1892p' ./TestFilesOut/cacti.sql

# SqlConf3_2()
# {
# LOG_ERROR "Edit Test 3.1"
# # 模拟场景二: 修改MySQL语句中的变量(不大于10行)
# # 步骤1, 定位字符串,找到首字段所在行
# # 步骤2, 判断新增字段是否存在
# # 步骤3.1, 不存在则以 \"method\" <恒存在>为母版，在其上修改为新增字段
# # 步骤3.2, 存在则直接修改该字段
# # v0.0.1(2014-08-04) : 兼容 ")," 或 ");" 并可自定义
# # v0.0.2(2014-08-04) : 重复项(只须限定范围,范围本身不可重复)
	# FILE=$1       # 文件名称
	# START=$2      # 开始标志
	# ADDFLG=$3     # 分割标志
	# CONTENT=$4    # 更改内容
	# ADDWHERE=$5   # 第几段内容

	# # LOG_INFO "Found : $FILE"
	# # awk -F"," -v RS="," 'BEGIN{ FS=OFS="INSERT"  }{
	# # print $1;
	# # }' $FILE

	
	# # awk 'BEGIN{ FS=OFS","; RS=ORS=","  }{
	# # print $1
	# # }' $FILE
	
	# ss=$(grep -n "$START" "$FILE" | cut -d ':' -f 1)
	# echo "ss=$ss"
	
	# tmp=$(grep -n "$START" $FILE)
	# echo "tmp=$tmp"
	
	# #awk '/INSERT INTO/{FS=OFS=","}{$7="2"}1' $FILE
# } 
# SqlConf3_2 "./TestFilesOut/cactitest.sql"  "INSERT INTO \`host\` VALUES"  ","  2  6 
# SqlConf3_2 "./TestFilesOut/cactitest.sql"  "INSERT INTO host_graph VALUES"  ","  2  6 


Name="Table structure for table"

[ -e TestFilesCsplit ] && rm -rf TestFilesCsplit
mkdir TestFilesCsplit
cd TestFilesCsplit
# time csplit ../TestFilesOut/cacti.sql /"-- Table structure for table*"/-2  -n 3 {*}

# 获取
time awk "/$Name/{i++ }{print > \"file\"i}" ../TestFilesOut/cacti.sql

Num=0
for i in $(grep -n "^-- Table structure for table.*$" "../TestFilesOut/cacti.sql" | cut -d ' ' -f 6 | cut -d '`' -f 2)
do 
	Num=$(($Num+1))   
	mv "file$Num" "$Num$i.sql"
done









