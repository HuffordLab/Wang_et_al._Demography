#!/usr/bin/perl
# USAGE:
# unix command line:
use strict;
use warnings;

my $inFile = shift @ARGV;    # read file names from terminal input
open IN, '<', $inFile or die "Cannot open '$inFile' because: $!";



while (<IN>){
chomp;

my @tmpo=split("\t", $_);
print "$tmpo[0]\t$tmpo[1]\t";
for (my $i=2; $i<=$#tmpo; $i++){

if ($tmpo[$i]  eq "AA"){
$tmpo[$i] = "A"
}#if

elsif ($tmpo[$i]  eq "TT"){
$tmpo[$i] = "T"
}#if

elsif ($tmpo[$i]  eq "CC"){
$tmpo[$i] = "C"
}#if

elsif ($tmpo[$i]  eq "GG"){
$tmpo[$i] = "G"
}#if

elsif (($tmpo[$i]  eq "AG") || ($tmpo[$i]  eq "GA") ){
$tmpo[$i] = "R"
}#if

elsif (($tmpo[$i]  eq "CT") || ($tmpo[$i]  eq "TC") ){
$tmpo[$i] = "Y"
}#if

elsif (($tmpo[$i]  eq "AC") || ($tmpo[$i]  eq "CA") ){
$tmpo[$i] = "M"
}#if

elsif (($tmpo[$i]  eq "GT") || ($tmpo[$i]  eq "TG") ){
$tmpo[$i] = "K"
}#if

elsif (($tmpo[$i]  eq "GC") || ($tmpo[$i]  eq "CG") ){
$tmpo[$i] = "S"
}#if

elsif (($tmpo[$i]  eq "AT") || ($tmpo[$i]  eq "TA") ){
$tmpo[$i] = "W"
}#if

elsif ($tmpo[$i]  eq "NN"){
$tmpo[$i] = "N"
}#if

else{
print "dummy, you are making mistakes!";
}
print "$tmpo[$i]\t";
} #for

print "\n";
} #while
   
close IN;





