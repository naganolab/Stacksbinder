#!/usr/bin/perl -w
#
#
# by M.Mihara
#
### USAGE ######################################################################
our $USAGE = <<_USAGE_;

NAME
   $0 

USAGE
   $0  -i <INPUT>  

   -i INPUT ... Stacks output File

OUTPUT
   XXXXXXXXX

_USAGE_
### USAGE ######################################################################

use strict;
use Getopt::Long;
use File::ReadBackwards;

sub usage {
  print $USAGE;
  exit;
}
my $input="";
GetOptions(
    'input=s' => \$input
);

#Input check
if(!$input || !-e "$input"){&usage;}

my @samples=();
my $bw = File::ReadBackwards->new($input)
  or die "Can't open file $input: $!\n";

while(my $n = $bw -> readline()) {
   $n=~s/\r\n|\r|\n//ig;
   next if !$n;
   if($n=~/^[\w#]/){
     last;
   }elsif($n=~/^\t/){
     $n=~s/^\t+//;
     my ($id,$name)=split(/\t/,$n);
     push @samples,$name;
   }
}
$bw -> close();

printf "%d", scalar @samples;

exit;

