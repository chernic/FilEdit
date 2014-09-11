#!/bin/sh

cat > inputfile <<EOF
1 aaa
1 bbb
2 aaa
1 ccc
2 bbb
3 aaa
EOF
if [ $# -ne 2 ]; then
        echo "Usage: <program_name> <filename> <column_num>"
        echo "Example: ./GetImport.sh  inputfile 2"
        exit 1
fi

FILENAME=$1
COLUMN=$2

COMMAND="awk '{
	a[\$$COLUMN]+=1; 
	if(a[\$$COLUMN]==1) 
	print \$$COLUMN
}' $FILENAME"

eval $COMMAND
