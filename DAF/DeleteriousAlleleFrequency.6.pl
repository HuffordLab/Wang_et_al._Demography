#!/usr/bin/perl
# USAGE:
# unix command line:
use strict;
use warnings;

my $infile = shift @ARGV;    # read file names from terminal input
open IN, '<', $infile or die "Cannot open '$infile' because: $!";


my $output_file = shift @ARGV; #change the output file name here
open (OUT, ">", $output_file);




while (<IN>){
chomp;
my @tmpo=split("\t",$_);
next if /^ids/;
my $n1=0; #count of 0/0
my $n2=0; #count of 0/1
my $n3=0; #count of 1/1

for (my $i=9; $i <=$#tmpo; $i++){
if($tmpo[$i] =~ m/^0\/0/){
$n1++;
}#if
elsif($tmpo[$i] =~ m/^0\/1/){
$n2++;
}#elsif
elsif($tmpo[$i] =~ m/^1\/1/){
$n3++;
}#elsif
}#for
my $DAF;
next if ($n1+$n2+$n3 < 6); #change the number here for different pop
if ($tmpo[$#tmpo] eq "yes"){
$DAF=(1*$n2 + 2*$n3) / (($n1+$n2+$n3)*2);
}
elsif($tmpo[$#tmpo] eq "no"){
$DAF=(1*$n2 + 2*$n1) / (($n1+$n2+$n3)*2);
}

print OUT "$_\t$DAF\n";
} #while


   
close IN;
close OUT;


