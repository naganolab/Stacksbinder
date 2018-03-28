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
   $0  -i <INPUT> -n  

   -i INPUT ... Stacks log File
   -n       ... output sample size only 

OUTPUT
   XXXXXXXXX

_USAGE_
### USAGE ######################################################################

use strict;
use Getopt::Long;

sub usage {
  print $USAGE;
  exit;
}
my $input="";
my $flg_ssize=0;
my $DEBUG=0;
GetOptions(
    'input=s' => \$input,
    'number' => \$flg_ssize
);

#Input check
if(!$input || !-e "$input"){&usage;}

my $version="";
my $cmd_stacks="";
my $dbname="";
my $batch_id="";
my $sample="";
my @samples=();
open my $fh,'<',$input or die "Can not open $input($!)\n";
while(my $n=<$fh>){
   $n=~s/\r\n|\r|\n//ig;
   if($n=~/ref_map.pl|denovo_map.pl/ && !$cmd_stacks){
      if($n=~/version/){
         $version=$n;
      }else{
         $cmd_stacks=$n;
      }
   }
   elsif($n=~/Identifying unique stacks; [\w\s]+ \[([\w_\.]+)\]/){
      $sample=$1;
   }
   elsif($n=~/ Analyzed (\d+) sequence reads/){
      my $sample_hash->{"$sample"}=$1;
      push @samples, $sample_hash;
   }
   elsif($n=~/ read (\d+) sequence IDs\./){
      my $sample_hash->{"$sample"}=$1;
      push @samples, $sample_hash;
   }
   elsif($n=~/ Kept (\d+) primary alignments/){
      my $sample_hash->{"$sample"}=$1;
      push @samples, $sample_hash;
   }
}
close $fh;

if($cmd_stacks=~/ *\-B *([\w_\.]+)/){
   $dbname=$1;
}
if($cmd_stacks=~/ *\-b *([\w_\.]+)/){
   $batch_id=$1;
}

$cmd_stacks=~s/ *(\-s|\-r|\-p) *[\w\/_\.]+ *//ig;
$cmd_stacks=~s/[\w\/_\.]+(ref_map.pl|denovo_map.pl)/$1/;

my $num_sample=scalar @samples;

#use Data::Dumper;
#print Dumper(\@samples)."\n";
my @vec=();
my @nms=();
my $total_readnum=0;
foreach my $sm (@samples){
    foreach my $sname (keys %{$sm}){
        push @vec, $sm->{$sname};
        push @nms, "\"$sname\"";
        $total_readnum+=$sm->{$sname};
        #print "$sname\t$sm->{$sname}\n";
    }
}

if($flg_ssize){
  print $num_sample; 
  exit;
}

print qq{
version <- "$version"
dbname <- "$dbname"
batch_id <- $batch_id
cmd_stacks <- "$cmd_stacks"
sample_num <- $num_sample
totalread_num <- $total_readnum
};


print "sample2readnum <- c(",join(",",@vec),")\n";
print "names(sample2readnum) <- c(",join(",",@nms),")\n";

exit;

