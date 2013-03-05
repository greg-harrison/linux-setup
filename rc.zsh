function upsert_path () {
  if [ "$(echo $PATH | grep $1)" = "" ]; then
    if [ $2 = "left" ]; then
      export PATH="$1:$PATH"
    else
      export PATH="$PATH:$1"
    fi
  fi
}
if [[ $TERM == 'screen-256color' ]]; then
  export TERM=screen
fi

if [[ `uname` == 'Darwin' ]]; then
  export IS_OSX=1
fi

export RCDIR=$HOME/.rc
export TRIP_RCDIR=$HOME/.trip_rc

if [ -d "$RCDIR/bin" ] ; then
  upsert_path "$RCDIR/bin" left
fi

export RVM_HOME=$HOME/.rvm

# rvm!
[[ -s "$RVM_HOME/scripts/rvm" ]] && . "$RVM_HOME/scripts/rvm"


export ZSH=$RCDIR/submodules/oh-my-zsh.git
export ZSH_THEME="fishy"

#plugins=(vi-mode rvm tmux)
plugins=(rvm tmux)

source $RCDIR/submodules/oh-my-zsh.git/oh-my-zsh.sh
source $RCDIR/submodules/zsh-syntax-highlighting.git/zsh-syntax-highlighting.zsh
source $RCDIR/submodules/zsh-history-substring-search.git/zsh-history-substring-search.zsh
[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   history-substring-search-up
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" history-substring-search-down
export PROMPT="$PROMPT%{$(echo "\a")%}"

stty ixany
stty ixoff -ixon

setopt INC_APPEND_HISTORY

# vim stuff
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '^Xe' edit-command-line
export EDITOR="vim -X"

# For tmux
#export DISPLAY=:0.0
unset DBUS_SESSION_BUS_ADDRESS

# other cool keyboard shortcuts
bindkey '^Xp' push-line
zle -N rerun-with-sudo
bindkey '^Xx' rerun-with-sudo

#[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   history-substring-search-up
#[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" history-substring-search-down


rerun-with-sudo () {
  LBUFFER="sudo !!"
  zle accept-line
}

function get_diff_out () {
  GIT_DIFF_OUT=~/diffs/`git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`.diff 
}

function git_diff () {
  get_diff_out
  if [ "$1" = "c" ]
  then
    rm -f $GIT_DIFF_OUT 2> /dev/null
    rm -f $GIT_DIFF_OUT.old 2> /dev/null
  fi
  cp "$GIT_DIFF_OUT" "$GIT_DIFF_OUT.old" 2> /dev/null
  git svn-diff > $GIT_DIFF_OUT
  if [ -e "$GIT_DIFF_OUT.old" ]
  then
    diff $GIT_DIFF_OUT.old $GIT_DIFF_OUT
  else
    cat $GIT_DIFF_OUT
  fi
}

function -- () {
  popd
}

function tmd {
  tmux attach-session -dt $1
}

function tm {
  tmux attach-session -t $1
}

function suspend {
  sudo su -c 'gnome-screensaver-command --lock && dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend'
}

function sst {
  svn stat $@ | grep -v '^[?X]\|Per\|^$'
}

alias lsdf='get_diff_out;cat ;echo ;'
alias o=gnome-open
alias rb='git svn rebase'
alias sdf=git_diff
alias yu='sudo apt-get update && sudo apt-get upgrade'
alias xp='echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\"" && xprop | grep "WM_WINDOW_ROLE\|WM_CLASS"'
alias todo="$HOME/software/todo.txt-cli/todo.sh"
alias ack='ack-grep'
alias glo='killall gnome-session'

if [ $IS_OSX ]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -lh'

if [ -d "$TRIP_RCDIR" ]; then
  upsert_path "$TRIP_RCDIR/bin" left
  source $TRIP_RCDIR/trip_zsh
else
  unset TRIP_RCDIR
fi
