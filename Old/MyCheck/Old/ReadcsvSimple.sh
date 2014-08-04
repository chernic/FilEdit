#!/usr/bin/perl -w
my $dir=`pwd`;
opendir DH, $dir;
my $cut=2;
foreach $file (readdir DH){
	next if $file =~ /^\./;
	open FH,$file;
	my @readf = <FH>;
	chomp $file;

	print "$file ==> ",$readf[$cut];
}
