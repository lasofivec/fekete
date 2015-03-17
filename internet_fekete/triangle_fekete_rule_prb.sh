#!/bin/bash
#
gfortran -c triangle_fekete_rule_prb.f90
if [ $? -ne 0 ]; then
  echo "Errors compiling triangle_fekete_rule_prb.f90"
  exit
fi
#
gfortran triangle_fekete_rule_prb.o -L$PWD -ltriangle_fekete_rule
if [ $? -ne 0 ]; then
  echo "Errors linking and loading triangle_fekete_rule_prb.o"
  exit
fi
rm triangle_fekete_rule_prb.o
#
mv a.out triangle_fekete_rule_prb
./triangle_fekete_rule_prb > triangle_fekete_rule_prb_output.txt
if [ $? -ne 0 ]; then
  echo "Errors running triangle_fekete_rule_prb"
  exit
fi
rm triangle_fekete_rule_prb
#
convert fekete_rule_1.eps fekete_rule_1.png
convert fekete_rule_2.eps fekete_rule_2.png
convert fekete_rule_3.eps fekete_rule_3.png
convert fekete_rule_4.eps fekete_rule_4.png
convert fekete_rule_5.eps fekete_rule_5.png
convert fekete_rule_6.eps fekete_rule_6.png
convert fekete_rule_7.eps fekete_rule_7.png
rm *.eps
#
echo "Test program output written to triangle_fekete_rule_prb_output.txt."
