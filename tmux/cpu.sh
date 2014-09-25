#!/bin/sh
if [ $IS_OSX ]; then
  top -l 1 | head -n 10 | grep CPU | grep -Eo '\d*\.\d*% user' | cut -d'%' -f 1
else
  mpstat 1 | head -n 4 | tail -n 1 | awk '{printf("%.2f", 100-$13)}'
fi
