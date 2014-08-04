#!/bin/sh
#####################################################
# Version : 0.0.1
# Make by Chernic.Y.Chen @ China
# E-Mail : iamchernic@gmail.com
# Date : 2014-7-1
# Tool Needed : xmlstarlet
#####################################################

outfile=$1
tabs=0


put_head(){
	put '<?'${1}'?>' > $outfile
}

put(){
	echo '<'${*}'>' >> $outfile
}

out_tabs(){
	tmp=0
	tabsstr=""
	while [ $tmp -lt $((tabs)) ]
	do
		tabsstr=${tabsstr}'\t'
		tmp=$((tmp+1))
	done
	echo -e -n $tabsstr >> $outfile
}

tag_start(){
	out_tabs
	put $1
	tabs=$((tabs+1))
}

tag_substart(){
	put $1
	tabs=$((tabs+1))
}

tag_end(){
	tabs=$((tabs-1))
	out_tabs
	put '/'${1}
}

tag_value(){
	out_tabs
	str=""
	str=${1}' value="'${2}'"/'
	put $str
}


