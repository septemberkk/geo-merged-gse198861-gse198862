use strict;
use warnings;

my $file1=$ARGV[0];           
my $file2=$ARGV[1];           
my $out=$ARGV[2];               
my %hash=();                  

open(RF,"$file1") or die $!;    
while(my $line=<RF>){
  chomp($line);
  my @arr=split(/\t/,$line);
  my $gene=shift(@arr);
  $hash{$gene}=join("\t",@arr);
}
close(RF);

open(RF,"$file2") or die $!;    
open(WF,">$out") or die $!;    
while(my $line=<RF>){
  chomp($line);
  my @arr=split(/\t/,$line);
  my $gene=shift(@arr);
  if(exists $hash{$gene}){
  	print WF $gene . "\t" . $hash{$gene} . "\t" . join("\t",@arr) . "\n";
  }
}
close(WF);
close(RF);

