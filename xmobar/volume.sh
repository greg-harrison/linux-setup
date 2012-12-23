#!/bin/sh
max=100000
step=10
inc=$(($max/$step))

pct=$(($(pa-vol)))
if [ "$(pa-mute)" = "no" ]; then
  vbox=■
else
  vbox=-
fi

vol=''
for i in `seq 1 $step`; do
  if [ $pct -gt 0 ]; then
    pct=$(($pct - $inc))
    vol="$vol$vbox"
  else
    vol="$vol "
  fi
done

echo "[$vol]"
