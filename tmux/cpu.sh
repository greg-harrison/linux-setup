#!/usr/bin/env sh
mpstat 1 | head -n 4 | tail -n 1 | awk '{printf("CPU:%.2f%", 100-$13)}'
