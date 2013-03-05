#!/bin/sh


MEM=$(free -t | grep Mem | awk '{printf("%d", (($3-$7) / $2) * 100)}')
SWAP=$(free -t | grep Swap | awk '{printf("%d", ($3 / $2) * 100)}')

echo "Mem:$MEM%|$SWAP%"
