#!/bin/sh

vmstat -a | tail -n 1 | awk '{printf("Mem:%.2f%\n", ($6)/($4+$5) * 100.0)}'
