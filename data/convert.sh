#!/bin/bash
cd ./physionet.org/files/mitdb/1.0.0/
FILES=./*.hea

# For all record files run conversion to Matlab compatible file
for f in $FILES
do
  f=$(basename $f)
  f=${f%.*}
  echo $f
  wfdb2mat -r $f
done
