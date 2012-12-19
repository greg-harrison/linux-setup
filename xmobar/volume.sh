#!/bin/sh
pct=$(amixer get Master|grep -o '\([0-9]\+\)%' | grep -o '[0-9]\+')
if [ $(amixer get Master|grep -o '\(\[on\]\)') ]; then
  vbox=■
else
  vbox=-
fi

vol=''
inc=10

for i in `seq 1 $((100/$inc))`; do
  if [ $pct -gt 0 ]; then
    pct=$(($pct - $inc))
    vol="$vol$vbox"
  else
    vol="$vol "
  fi
done

echo "[$vol]"
