#!/bin/sh
if [ $TMUX_TAB_COLOR ]; then
  echo "#[$1=$TMUX_TAB_COLOR]"
else
  echo "#[$1=#11AADD]"
fi
