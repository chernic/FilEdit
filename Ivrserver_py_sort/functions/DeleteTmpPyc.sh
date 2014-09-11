#!/bin/sh

if [ "$1" == "1" ];then
	time What2DelRegex=$(find . -regextype posix-egrep -regex  ".*\.(pyd|pyc)")
fi
if [ "$1" == "2" ];then
	echo "Only This Dir"
	time What2Del=$(find . -name *.pyc)
fi



for var in $What2DelRegex
do
    #echo "Del $var"
	rm -v $var
done
