#!/bin/bash
#
#  Revision: 1.1.0 
#  Date: 2018/03/20
#  Copyrigth (c) 2018
#
#  RAD-seq Report System
#

#setting file
DIR_SCR="$(cd $(dirname $0); pwd)"

SCR_PARSE="${DIR_SCR}/perl/parseStacksLog.pl"
SCR_R="${DIR_SCR}/R/RADseqReportSystem.R"

HTML_DESC="${DIR_SCR}/figexp_e.html"

BIN_R="/usr/bin/Rscript";
export LD_LIBRARY_PATH=/opt/bio/local/gcc/lib64/:$LD_LIBRARY_PATH


#
#  USAGE
#
usage_exit () {
cat <<_EOT_
  Usage:
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
                       
_EOT_
  exit;
}

#	character limit
escape_str () {
   ESCAPESTR=`echo $1 | sed  -e "s/[^a-zA-Z0-9_/.-]//g"`
   echo ${ESCAPESTR}
}
escape_str_dir () {
   ESCAPESTR=`echo $1 | sed  -e "s/[^a-zA-Z0-9_-]//g"`
   echo ${ESCAPESTR}
}

while getopts i:s:t:x:y:p:o:h OPT
do
    case $OPT in
       i) ST_LOG=$OPTARG
         ;;
       s) ST_OUT=$OPTARG
         ;;
       t) TITLE=$OPTARG
         ;;
       x) ENZ1=$OPTARG
         ;;
       y) ENZ2=$OPTARG
         ;;
       p) POLY=$OPTARG
         ;;
       o) DIR_OUT=$OPTARG
         ;;
       h) usage_exit
         ;;
    esac
done

ST_LOG=`escape_str "${ST_LOG}"`
ST_OUT=`escape_str "${ST_OUT}"`
TITLE=`escape_str_dir "${TITLE}"`
ENZ1=`escape_str "${ENZ1}"`
ENZ2=`escape_str "${ENZ2}"`
POLY=`escape_str "${POLY}"`
DIR_OUT=`escape_str_dir "${DIR_OUT}"`

FLG_ERROR=0
if [ ! -n "${ST_LOG}" ];then
   echo "[Error] stacks log is empty"
   FLG_ERROR=1
fi
if [ ! -n "${ST_OUT}" ];then
   echo "[Error] stacks output is empty"
   FLG_ERROR=1
fi
if [ ! -n "${TITLE}" ];then
   echo "[Error] title is empty"
   FLG_ERROR=1
fi
if [ ! -n "${DIR_OUT}" ];then
   echo "[Error] output directory is empty"
   FLG_ERROR=1
fi
if [ $FLG_ERROR == 1 ];then
   usage_exit
fi

echo "[IN]stacks log:${ST_LOG}"
echo "[IN]stacks out:${ST_OUT}"
echo "[IN]title:${TITLE}"
echo "[IN]enzyme1:${ENZ1}"
echo "[IN]enzyme2:${ENZ2}"
echo "[IN]polymerase:${POLY}"
echo "[IN]output directory:${DIR_OUT}"

unset INPUT
trap '[[ "$INPUT" ]] && rm -f $INPUT' 1 2 3 15
INPUT=$(mktemp 2>/dev/null||mktemp -t tmp)

#parse Stacks log file
echo -n "Exe ... Parse"
${SCR_PARSE} -i ${ST_LOG} > ${INPUT}
echo " ... Finish"

#Rscript
echo "Exe ... Rscript"
${BIN_R} --vanilla "${SCR_R}" "${INPUT}" "${ST_OUT}" "${TITLE}" "${ENZ1}" "${ENZ2}" "${POLY}" "${DIR_OUT}" "${HTML_DESC}" 
echo " ... Finish"


if [ -e "${INPUT}" ];then
   rm -fr ${INPUT}
fi



