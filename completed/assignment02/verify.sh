#!/bin/sh

expected=$(ls | grep expected)
myscript=$(ls | grep Homan)

(Rscript $myscript | diff - $expected)
if [ $? -eq 0 ]; then
  echo "SUCCESS"
else
  echo "FAIL"
fi
