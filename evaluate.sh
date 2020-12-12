#!/bin/bash
cd ./data/physionet.org/files/mitdb/1.0.0/
FILES=./*.qrs

rm eval1.txt
rm eval2.txt

# For all record files run conversion to Matlab compatible file
for f in $FILES
do
  echo $f
  bxb -r $(basename "$f" .qrs) -a atr qrs -l eval1.txt eval2.txt
done

sumstats eval1.txt eval2.txt > results.txt

rm ../../../../../results/*
cp *.asc ../../../../../results/
cp results.txt ../../../../../results/
