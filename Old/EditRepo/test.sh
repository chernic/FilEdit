#!/bin/sh
BUILD_DIR=`pwd`

FILE=epel.repo
ls=epel

# 找出指定行
echo "******* Find The Line of [$ls]"
ss=$(grep -n '^\['$ls'\]' $FILE | cut -d ':' -f 1) && echo "$ss"

# 修改指定行的第一次出现的enabled
echo "******* disabled [$ls]"
sed -n $ss',/enable/ s/enabled.*/enabled=1/' $FILE

#如何用sed修改某一特定行的内容
#sed -i 's/[0-9]*/0/1' file

# # Find line enabled between epel and epel-debuginfo
# aa=$(awk 'BEGIN{s='$ss';e='$ee';IGNORECASE=1} \
     # s<=NR  \
	     # &&(/enabled/) \
		 # {print NR} \
     # NR>=e{exit}'  \
# $FILE)
# echo "$aa"
