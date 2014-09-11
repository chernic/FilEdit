#!/bin/sh

FileName="Importlist.sh"

echo "" >./$FileName
What2Import=$(find . -regextype posix-egrep -regex  ".*\.(py)")
for var in $What2Import
do
	What2Line=$(grep '^import.*' $var)
	echo "$What2Line" >> $FileName
	
	# for tmp in $What2Line
	# do
		# :
		# #echo "$tmp"
		# # grep '$tmp' $FileName
		# # if [ $? -eq 1 ];then
			# # echo "$tmp" >> $FileName
		# # fi
	# done
done


echo "Done"
cat $FileName