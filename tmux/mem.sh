#!/bin/sh

if [ $IS_OSX ]; then
  vm_stat 1 | head -n 3 | tail -n 1 | awk '{printf("%d%%", (($1 + $4) / ($1 + $2 + $4) * 100))}'
else
  free="$(free -t)"
  MEM=$(echo "$free" | grep Mem | awk '{printf("%d", (($3 - $7) / $2) * 100)}')

  echo "$MEM%"
fi
