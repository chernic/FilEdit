#!/bin/sh
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-6-12
#####################################################
# This Shell Script has been Test on RHEL-5
# This Shell Script has benn Test in Static/DHCP Mode
#####################################################
# Chernic's Report Head
LABLE3='\n\n>>> Cc@FS: '
LABLE2='\n>> Cc@FS: '
LABLE1='> Cc@FS: '
#####################################################
BUILD_DIR=`pwd`
# [获取本文件路径 的 文件名称] 即本文件名的配置文件
WGET_FILE=WgetSrc.conf
# 判断对应文件是否存在,若存在则导入
[ -f $WGET_FILE ] && . $WGET_FILE

src_url=$FCGI
	filename=${src_url##*/} && echo "filename=$filename"
	softwarename=${filename%-*} && echo "softwarename=$softwarename"
	version=$( echo "$filename" | sed -n '/^.*-/{s///;s/\.[a-z].*//;p}' ) && echo "version=$version"
	
# 提取文件全名方法一
echo -e $LABLE1"Method 1 (Shell) of getting filename"
	fileFCGI=${src_url##*/} &&	echo "$fileFCGI"
# 提取文件全名方法二(被查找字符串前面不能有空格)
echo -e $LABLE1"Method 2 (sed) of getting filename"
	

# 提取软件名称方法一
echo -e $LABLE1"Method 1 (Shell) of getting softwarename"
	CFCGI1=${fileFCGI%-*} && echo "$CFCGI1"
# 提取软件名称方法二(被查找字符串前面不能有空格)
echo -e $LABLE1"Method 2 (sed) of getting softwarename"
	echo "$fileFCGI" | sed -n 's/\-.*//;p'


# 提取版本号方法一
echo -e $LABLE1"Method 1 (Shell) of getting version"
	CFCGI2=${fileFCGI##*-}
	filetype=".tar.gz"
	CFCGI22=${CFCGI2%$filetype} && echo "$CFCGI22"
# 提取版本号方法二(被查找字符串前面可以有空格)
echo -e $LABLE1"Method 2 (sed) of getting version"
	echo "$fileFCGI" | sed -n '/^.*-/{s///;s/\.[a-z].*//;p}'
	
	

echo -e $LABLE2"Methods of getting word between"
	# 查找 - 到 .[a-z] 之间的内容
	echo " FCGI-0.74.tar.gz " | sed -n '/^.*-/{s///;s/\.[a-z].*//;p}'
	# 查找括号之间的内容
	echo " channel(123456)  xmitq(asf) " | awk -F'[()]' '{print $2}' 
	# 查找 [a-z](*) 中的 * 的部分中的内容
	echo " channel(123456)  xmitq(asf)" | sed 's/[a-z]*(\([^)]*\))/\1/g'


# #########################
# # 如何将字符串 “a001 login carp(256) carp(200)”中的256和200取出来？
# #########################
# time ( 
	# echo 'a001 login carp(256) carp(200)' | sed 's/[^(]*carp(\([0-9]*\))/\1 /g' 
# )
# time ( 
	# echo 'a001 login carp(256) carp(200)' | grep -o 'carp([0-9]\+' | grep -o '[0-9]\+'
# )

# time ( 
	# echo "a001 login carp(256) carp(200)" | awk -v RS=" " '$0~/carp(.*)/{print substr($0,index($0,"(")+1,index($0,")")-index($0,"(")-1)}'
# )

# time ( 
	# echo "a001 login carp(256) carp(200)" | tr ' ' '\n' | sed -nr 's/carp\((.*)\)/\1/p'
# )
# time ( 
	# echo "a001 login carp(256) carp(200)" | awk -F"[)(]+" '{for(i=2;i<=NF;i+=2)print NF,$i}'
# )
	
	
# #########################
# echo -e "\nHere is just a example."
# #########################
# cat > abc.txt << EOF
# ./5/9/4/20120627T145653_4feaaeb5000e1c0948b4ad04d27e5306.txt
# ./2/a/4/20120627T145602_4feaae820009ebba48b4ad04d27e5306.txt 
# ./4/1/f/20120627T155204_4feabba400051111803e210f45146c0d.txt 
# ./3/3/f/20120627T155251_4feabbd3000b7fa3803e210f45146c0d.txt
# EOF

# a=( $(sed -n 's/^.//;1h;1!H;$!b;$G;s/\n/ /g;p' abc.txt) )
# for (( i = 0; i < ${#a[@]}; ++i )); 
# do 
	# echo $i -- ${a[$i]}; 
# done;



