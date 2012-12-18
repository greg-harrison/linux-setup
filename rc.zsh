if [[ $TERM == 'screen-256color' ]]; then
  export TERM='screen'
fi

if [[ `uname` == 'Darwin' ]]; then
  export IS_OSX=1
fi

export RCDIR=$HOME/.rc
export TRIP_RCDIR=$HOME/.trip_rc

if [ -d "$RCDIR/bin" ] ; then
    PATH="$RCDIR/bin:$PATH"
fi

if [ $IS_OSX ]; then
  export RVM_HOME=$HOME/.rvm
else
  export RVM_HOME=/usr/share/ruby-rvm
fi

# rvm!
[[ -s "$RVM_HOME/scripts/rvm" ]] && . "$RVM_HOME/scripts/rvm"


export ZSH=$RCDIR/submodules/oh-my-zsh
export ZSH_THEME="fishy"

#plugins=(vi-mode rvm tmux)
plugins=(rvm tmux)

source $RCDIR/submodules/oh-my-zsh/oh-my-zsh.sh
source $RCDIR/submodules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $RCDIR/submodules/zsh-history-substring-search/zsh-history-substring-search.zsh

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
export DISPLAY=:0.0
unset DBUS_SESSION_BUS_ADDRESS

# other cool keyboard shortcuts
bindkey '^Xp' push-line
zle -N rerun-with-sudo
bindkey '^Xx' rerun-with-sudo

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

function tm {
  tmux attach-session -t $1
}

alias lsdf='get_diff_out;cat ;echo ;'
alias o=gnome-open
alias rb='git svn rebase'
alias sdf=git_diff
alias yu='sudo apt-get update && sudo apt-get upgrade'
alias xp='echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\"" && xprop | grep "WM_WINDOW_ROLE\|WM_CLASS"'
alias todo="$HOME/software/todo.txt-cli/todo.sh"
alias ack='ack-grep'

if [ $IS_OSX ]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -lh'

if [ -d "$TRIP_RCDIR" ]; then
  PATH="$TRIP_RCDIR/bin:$PATH"
  source $TRIP_RCDIR/trip_zsh
else
  unset TRIP_RCDIR
fi
