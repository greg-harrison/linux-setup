if [ -z $DISPLAY ]; then
  export DISPLAY=$(ls -l /tmp/.X11-unix/ | tail -n 1 | awk '{print $NF}' | sed 's/X/:/')
fi
if [ -n "$SSH_TTY" -a -z "$STY" ]; then
  export TERM=xterm-256color
  echo Tmux Sessions:
  tmux list-sessions
fi
