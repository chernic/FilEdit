#!/bin/sh

##模式匹配
GetImport()
{
    # 参数控制
    if [ $# -ne 4 ]; then
        echo "Usage: <InFile> <program_name> <FileType> <OtFile>"
        echo "Example: GetImport py import $FileOut"
        exit 1
    fi

    # 参数传递
	InFileName=$1
    InFileType=$2
    FileContent=$3
    OtFileName=$4
    echo "" >$OtFileName

    # 功能进行 What2Find=$(find . -regextype posix-egrep -regex  ".*\.($InFileType)")
    What2Find=$(find $InFileName -regextype posix-egrep -regex ".*\.($InFileType)")
    for var in $What2Find
    do
		echo "#$var" >> $OtFileName
        WhatInLine=$(grep "^$FileContent.*$" $var)
        echo "$WhatInLine" >> $OtFileName
    done
}


## 唯一筛选
GetUnique()
{
    # 参数控制
    if [ $# -ne 2 ]; then
            echo "Usage: <program_name> <filename> <column_num>"
            echo "Example: ./GetImport.sh  inputfile 2"
            exit 1
    fi

    # 参数传递
    FILENAME=$1
    COLUMN=$2

    # 功能进行
    COMMAND="awk '{
        a[\$$COLUMN]+=1;
        if(a[\$$COLUMN]==1)
        print \"import\" , \$$COLUMN
    }' $FILENAME"

    eval $COMMAND
}
