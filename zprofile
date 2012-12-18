if [ -n "$SSH_TTY" -a -z "$STY" ]; then
  export TERM=xterm-256color
  echo Tmux Sessions:
  tmux list-sessions
fi
