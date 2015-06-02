if [[ `uname` == 'Darwin' ]]; then
  export IS_OSX=1
fi
if [ -z $DISPLAY ] && [ -d /tmp/.X11-unix ]; then
#  export DISPLAY=$(ls -l /tmp/.X11-unix/ | tail -n 1 | awk '{print $NF}' | sed 's/X/:/')
  export DISPLAY=:0
fi
if [ -n "$SSH_TTY" -a -z "$STY" ]; then
  export TERM=xterm-256color
  echo Tmux Sessions:
  tmux list-sessions
fi
