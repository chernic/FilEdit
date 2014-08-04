#!/bin/sh


echo "###########################"
echo "# Checking  /etc/snmp/snmp.conf"
echo "###########################"

echo "####### This Line Must Be :"
echo "com2sec notConfigUser 127.0.0.1        public"
sed -n '41p' /etc/snmp/snmpd.conf
echo "                    #######"

echo "####### This Line Must Be :"
echo "access  noConfigGroup  \"\"      any       noauth    exact  all none none"
sed -n '62p' /etc/snmp/snmpd.conf
echo "                    #######"

echo "####### This Line Must Be :"
echo "view  all include     ./                              80"
sed -n '85p' /etc/snmp/snmpd.conf
echo "                    #######"