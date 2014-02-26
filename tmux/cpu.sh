#!/usr/bin/env sh
mpstat | grep -A 5 "%idle" | tail -n 1 | awk -F " " '{printf("CPU:%.2f%\n",100 -  $ 13)}'
