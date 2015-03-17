#!/bin/bash

gfortran -c ./triangle_fekete_rule_prb.f90
if [ $? -ne 0 ]; then
    echo "Errors compiling " $FILE
    exit
fi

#
ar qc libtriangle_fekete_rule.a *.o
#
echo "Library installed as"$PWD"/libtriangle_fekete_rule.a"
