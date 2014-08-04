#!/usr/bin/perl -w
use strict;
use feature 'say';
use Spreadsheet::ParseExcel;  ####excel操作模块


my $parser   = Spreadsheet::ParseExcel->new();  
my $workbook = $parser->parse('SnmpTest.xls');  ###打开excel文件

if (!defined $workbook) {
    die $parser->error(), ".\n";
}


my $worksheet = $workbook->worksheet('SnmpTest');  ###通常excel中可能会有几个工作表,选择一个当前excel的工作表

my ($row_min, $row_max) = $worksheet->row_range();  ###工作表行的范围
my ($col_min, $col_max) = $worksheet->col_range();  ###工作表列的范围


for my $row ($row_min .. $row_max) {
	for my $col ($col_min .. $col_max) {
		my $cell = $worksheet->get_cell($row,$col);  ###几行几列单元格的值
		say $cell;
	}
}