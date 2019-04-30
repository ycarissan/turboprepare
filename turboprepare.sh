#!/bin/sh

#BEGIN CONFIGURATION
# * EDIT DIRNAME TO THE PATH OF THE FILE functions_define.sh 
DIRNAME=$HOME/prog/turboprepare
#END CONFIGURATION

usage() {
  echo
  echo "  USAGE: "`basename $0`" -g geom.xyz [ -c MOLECULARCHARGE ] [ -b BASENAME ] [ -d FUNCNAME ] [-s]"
  echo
  echo " Automatically prepares the turbomole input for the geometry in geom.xyz"
  echo " -s epsilon for COSMO"
  echo "     infinity for water"
  echo
  exit 1
}

. ${DIRNAME}/functions_define.sh

GEOMFILE=""
KEEP=1
COSMO=0

while getopts ":c:g:b:d:s:w:kut" option
do
  case $option in
    d) #functional
       FUNC=$OPTARG
       ;;
    b) #basis set
       BASIS=$OPTARG
       ;;
    g) #geometry
       GEOMFILE=$OPTARG
       ;;
    c) #Charge of the molecule
       CHARGE=$OPTARG
       ;;
    k) #Keep tmp files
       KEEP=0
       ;;
    s) #Add cosmo
       COSMO=1
       EPSILON=$OPTARG
       ;;
    w) #wave function
       WF=$OPTARG
       ;;
    u) #unrestricted formalism
       UHF=1
       ;;
    t) #unrestricted formalism
       UHF=1
       SPIN="t"
       ;;
    :) usage
       ;;
    \?) usage
  esac
done

x2t ${GEOMFILE} > coord 

tmpfile=define.in_$RANDOM

generate_define_in > ${tmpfile}

define < $tmpfile

if [ $COSMO -eq 1 ]
then
  kdg end
  printf '$cosmo\n' >> control
  printf ' epsilon=%s\n' $EPSILON >> control
  printf '$end\n' >> control
fi

if [ $KEEP -eq 1 ]
then
  rm -fr $tmpfile
fi
