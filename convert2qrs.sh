#!/bin/bash
cd ./data/physionet.org/files/mitdb/1.0.0/
FILES=./*.asc

# For all record files run conversion to Matlab compatible file
for f in $FILES
do
  echo $f
  wrann -r $(basename "$f" .asc) -a qrs < $(basename "$f")
done
