# Stacksbinder  
Stacks binder offline version  
(c)2018 The Authors, see LICENSE for details.   

# Author  
Masaki Yasugi, Ayumi Tezuka and Atsushi J. Nagano.  

# Dependecies  
Perl > v5.10.1  
R > v3.3.3  
  
Perl modules
 - Getopt::Long ver 2.38 
 - File::ReadBackwards ver 1.05 

R libraries
 - hwriter ver 1.3.2
 - ggplot ver 1.0.1
 - grid ver 3.3.3
 - hexbin ver 1.27.0

# Installation  
1. Download the package and required R libraries and Perl modules.  
2. Place the packege as follwing;  
``` 
perl/ 
 ├ parseStacksLog.pl 
R/  
 ├ RADseqReportSystem.R  
figexp_e.txt  
RADseqReport.sh  
denovo_map.log or ref_map.log  
outputfile.tsv  
``` 

3. Run the ```  "RADseqReport.sh" ```  

# Usage  
``` 
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
``` 
# Reference  
J. Catchen, P. Hohenlohe, S. Bassham, A. Amores, and W. Cresko. Stacks: an analysis tool set for population genomics. Molecular Ecology. 2013.
# Citation  
M. Yasugi, A. Tezuka and A. J. Nagano (in submitted) Stacksbinder: online tools for visualizing and summarizing Stacks output to aid appropriate filtering of SNPs identified via RAD-Seq
