#!/bin/sh
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-7-1

OLDCSV=SnmpTest.csv
NEWCSV=SnmpTestO.csv

NEWSQL1=SnmpTestO1.sql
NEWSQL2=SnmpTestO2.sql
NEWSQL3=SnmpTestO3.sql

NewShell=SnmpTestO.sh

IPLocal=localhost
IPWindo=192.168.1.128
IPLinux=192.168.1.128
IPAddress=$IPLocal

# GetcsvRowToNewCsv
awk -F, -v OFS=, '{print $1,$3}' $OLDCSV > $NEWCSV

# GetcsvRowToNewSql
cat $OLDCSV | awk -F"," '{print "update tablename set c3=$3 where c1=$1;"}' > $NEWSQL1 
awk -F "," '{print "update tables set c3=\047" $1 "\047 where c1=\047" $3"\047;"}' $OLDCSV > $NEWSQL2


# 以下用脚本生成脚本
# csv文件末位有换行,所以每行最后一个元素带有换行符
# 最后一列不参与shell脚本运行,
echo  "#!/bin/sh" > $NewShell
cat $OLDCSV | awk -F"," '{print "         \
echo \"  *******  "$1"\";\n               \
snmpwalk -v2c -c public localhost  "$2}' >> $NewShell

sh $NewShell




