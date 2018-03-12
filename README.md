# Stacksbinder  
Stacks binder offline version  
(c)2018 The Authors, see LICENSE for details.   

#Author  
Masaki Yasugi, Ayumi Tezuka and Atsushi J. Nagano.  

#Dependecies  
Perl >  
R >  

#Installation  
1. Download the package.  
2. Place the packege as follwing;  

perl
-parseStacksLog.pl
R
-RADseqReportSystem.R
-init.sh
figexp_e.html
denovo_map.log or ref_map.log
outputfile.tsv
RADseqReport.sh

#Usage  
$0 -i [Stacks log] -s [Stacks output] -t [title] -o [OUTPUT DIR] (-x [enzyme1] -y [enzyme2] -p [polymerase])  
  
Description:  
RAD-seq Report System  
Options:  
    -i [Stacks log]   denovo_map.log / ref_map.log  
    -s [Stacks out]   outputfile.tsv [tsv]  
    -t [title]        title  
    -o [OUTPUT DIR]   output directory  
    -x [enzyme1]      enzyme1  
    -y [enzyme2]      enzyme2  
    -p [polymerase]   polymerase  

#Reference  

#Citation  
