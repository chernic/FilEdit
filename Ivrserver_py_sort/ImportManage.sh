#!/bin/sh



# 函数所在目录
DirFuc="./functions"
# 输入所在目录
DirInn="./in"
# 输出所在目录
DirOut="./ot"



## 工程1: 获取
# @.
Project1()
{
	source $DirFuc/GetImportUnique.sh

	FolderIn=$DirInn/Ivrserver_py.in
	FolderOt=$DirOut/GetImportUnique.out
	FileOut=$FolderOt/Importlist.py
	FileTmp=$FolderOt/ImportUnique.py


	[ -d $FolderIn ] && rm -rf $FolderIn
	tar jxf $DirInn/Ivrserver_py.in.tar.bz2 -C $DirInn
	[ -d $FolderOt ] && rm -rf $FolderOt
	mkdir $FolderOt

	echo -ne "Time of GetImport :"
	time GetImport $FolderIn py import $FileOut
		# 删去Windows下的\r 以免匹配出错
		sed -i "s@\r@@g" $FileOut
		# ,换成import 允许一行多次import的情况
		sed -i "s@\,@\nimport @g" $FileOut
		# 删除空行
		sed -i "/^$/d" $FileOut
		sed -i "/^[[:space:]].*$/d" $FileOut
		sed -i "s@^#.*@import os &@g" $FileOut
	echo "#-*-coding:cp936-*-" > $FileTmp
	
	echo -ne "Time of GetUnique :"
	time GetUnique $FileOut 2 | sort >> $FileTmp
	#cat $FileTmp
}




## 工程2: 根据源代码文件所在目录,改变import的导入路径
# @.支持源代码库下一级目录
Project2()
{
	source $DirFuc/ChangeInport.sh


	###
	FolderIn=$DirInn/Ivrserver_py.in
	FolderOt=$DirOut/GetImportUnique.out

	FilList="$FolderOt/PythonList.py"
	FileOut="$FolderOt/ImportlistForRoot.py"

	FileOut0="$FolderOt/Importlist0.py"
	FileOut1="$FolderOt/Importlist1.py"
	FileOut2="$FolderOt/Importlist2.py"
	FileOut3="$FolderOt/Importlist3.py"

	MissName=(
		"__init__"
	);

	ExampleName=(
		"xmlloader"
		"xmlloader2"
		"xmlloader"
	)



	###
	[ -d $FolderIn ] && rm -rf $FolderIn
	tar jxf $DirInn/Ivrserver_py.in.tar.bz2 -C $DirInn
	[ -d $FolderOt ] && rm -rf $FolderOt
	mkdir $FolderOt


	GetImport        $FolderIn/base  py  $FileOut0
		SedChangeImport  $FolderIn/base  py  $FileOut1
		
		echo -ne "Time of ChangeImport2 :"
		time ChangeImport2     $FolderIn/base  py  $FileOut
		#time ChangeImport1    $FolderIn/base  py  $FileOut
		
		SedChangeImport  $FolderIn/base  py  $FileOut2
	GetImport        $FolderIn/base  py  $FileOut3


	###
	sed -i "1,50{
		s/.*import.*FlowDef.*$/import FlowDef/g
	}" $FolderIn/base/python/AgentProxyInterface.py

	sed -i "1,50{
		s/.*import.*FlowDef.*$/import FlowDef/g
	}" $FolderIn/base/python/BaseNode.py

	sed -i "1,50{
		s/.*import.*BaseNode.*$/import BaseNode/g
	}" $FolderIn/base/python/FlowDef.py
}




## 管理1: 清除临时文件/过程文件
# @.清除编译文件 pyc/pyd
Manage1()
{
	source $DirFuc/DeleteTmpPyc.sh
}


Project1;
Project2;
#Manage1;