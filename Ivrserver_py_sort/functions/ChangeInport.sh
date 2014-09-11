#!/bin/sh
FileMiss()
{
    PYName=$1
    #MissName=$2

    if [[ "${MissName[@]}" =~ "$PYName" ]]
    then
        #echo "Hi We Continue!"
        continue
    fi
}


#模式匹配
ChangeImport1()
{
    # 参数控制
    if [ $# -ne 3 ]; then
        echo "Usage: <FolderName>  <program_name> <FileType> <TmpFile>"
        echo "Example: GetImport py import $FileName"
        exit 1
    fi

    # 参数传递
    FolderName=$1
    InFileType=$2
    OtFileName=$3

    # 功能进行
    What2Find=$(find  $FolderName -regextype posix-egrep -regex ".*\.($InFileType)")
    What2Change=$(find  $FolderName -regextype posix-egrep -regex ".*\.($InFileType|so)")
    echo "" > $OtFileName
    for lin in $What2Change
    do
        PYName="$(basename $lin .py)"
        PYName="$(basename $PYName .so)"
        FileMiss $PYName $MissName
        PYDir="${lin%/*}"
        PYSDir="${PYDir##*$FolderName}"
        PYSSDir="${PYSDir#*/}"

        IMPORT2Change="from .. $PYSSDir import $PYName"
        echo "from base.$PYSSDir import $PYName" >> $OtFileName

        [ "$PYName" == "FocuFileHandler" ] && IMPORT2Change="from .. $PYSSDir.$PYName import DateRotatingFileHandler "

        for var in $What2Find
        do
            sed -i "s@^import.*$PYName.*\$\|^from.*$PYName.*\$@$IMPORT2Change@g" $var
        done
    done
}

#模式匹配
ChangeImport2()
{
    # 参数传递
    FolderName=$1
    InFileType=$2
    OtFileName=$3

    # 功能进行
    What2Find=$(find  $FolderName -regextype posix-egrep -regex ".*\.($InFileType)")
    What2Change=$(find  $FolderName -regextype posix-egrep -regex ".*\.($InFileType|so)")

    for lin in $What2Change
    do
        PYName="$(basename $lin .py)"
        PYName="$(basename $PYName .so)"
        FileMiss $PYName #$MissName
        PYDir="${lin%/*}"
        PYSDir="${PYDir##*$FolderName}"
        PYSSDir="${PYSDir#*/}"

        for var in $What2Find
        do
            # real  2m36.991s ==> real  2m29.574s ==> real	2m20.777s
            
            # 库下的次层源文件的类Import
            IMPORT2Change="from .. $PYSSDir.$PYName import * "
            #sed -i "s@^from.*$PYName.*\$@$IMPORT2Change@g" $var
            sed -i "1,50{
                s/^from.*$PYName.*\$/$IMPORT2Change/g
            }" $var

            if [[ "${ExampleName[@]}" =~ "$PYName" ]]
            then
                IMPORT2Change="import base.$PYSSDir.$PYName"
            else
                # 库下的次层源文件Import
                IMPORT2Change="from .. $PYSSDir import $PYName"
            fi
            #sed -i "s@^import.*$PYName\$@$IMPORT2Change@g" $var
            sed -i "1,50{
                s/^import.*$PYName\$/$IMPORT2Change/g
            }" $var
        done
    done
}

#模式匹配
SedChangeImport()
{
    # 参数控制
    if [ $# -ne 3 ]; then
        echo "Usage: <FolderName>  <program_name> <FileType> <TmpFile>"
        echo "Example: GetImport py import $FileName"
        exit 1
    fi

    # 参数传递
    FolderName=$1
    InFileType=$2
    OtFileName=$3

    # 功能进行
    What2Find=$(find  $FolderName -regextype posix-egrep -regex ".*\.($InFileType)")
    What2Change=$What2Find

    echo "$What2Find" > $FilList
    echo "" > $OtFileName
    for lin in $What2Change
    do
        PYName="$(basename $lin .py)"
        FileMiss $PYName $MissName
        for var in $What2Find
        do
            #echo "#$var" >> $OtFileName
            WhatInLine1=$(grep "^import.*$PYName$" $var)
            WhatInLine2=$(grep "^from.*$PYName.*$" $var)
            [ "$WhatInLine1" != "" ] && echo "$WhatInLine1" >> $OtFileName
            [ "$WhatInLine2" != "" ] && echo "$WhatInLine2" >> $OtFileName
        done
    done
}

#模式匹配
GetImport()
{
    # 参数控制
    if [ $# -ne 3 ]; then
        echo "Usage: <FolderName>  <program_name> <FileType> <TmpFile>"
        echo "Example: GetImport py import $FileName"
        exit 1
    fi

    # 参数传递
    FolderName=$1
    InFileType=$2
    OtFileName=$3
    echo "" > $OtFileName

    # 功能进行
    What2Find=$(find  $FolderName -regextype posix-egrep -regex ".*\.($InFileType)")

    for var in $What2Find
    do
        echo "#$var" >> $OtFileName
        WhatInLine1=$(grep "^import.*$" $var)
        WhatInLine2=$(grep "^from.*$" $var)
        [ "$WhatInLine1" != "" ] && echo "$WhatInLine1" >> $OtFileName
        [ "$WhatInLine2" != "" ] && echo "$WhatInLine2" >> $OtFileName
    done
}







# PYName="__init__1"
# MissName=(
    # "__init__"
    # "__init__1"
# );

# echo "$PYName"
# echo "$MissName"

# if [[ "${MissName[@]}" =~ "$PYName" ]]
# then
    # echo "Hi We Continue!"
    # #continue
# fi



    # # 删去Windows下的\r 以免匹配出错
    # sed -i "s@\r@@g" $FileOut
    # # ,换成import 允许一行多次import的情况
    # sed -i "s@\,@\nimport @g" $FileOut
    # # 删除空行
    # sed -i "/^$/d" $FileOut
    # sed -i "/^[[:space:]].*$/d" $FileOut
    # sed -i "s@^#.*@import os &@g" $FileOut
# echo "#-*-coding:cp936-*-" > $FileTmp
# GetUnique $FileOut 2 | sort >> $FileTmp
# cat $FileTmp