set -g base-index 1
set -s escape-time 0

# Status
set-option -g status on
set-option -g status-interval 1
set-option -g status-utf8 on
set-option -g status-justify "left"
set-option -g status-left-length 60
set-option -g status-right-length 90
set-option -g status-bg "#222222"
set-option -g status-fg "white"
set -g window-status-activity-attr "bold"
set-window-option -g monitor-activity on
set-window-option -g aggressive-resize on
set-window-option -g window-status-activity-attr bold
set-window-option -g window-status-bell-attr bold

set-option -g window-status-format "#[fg=#333333,bg=#333333] #[fg=white]#I#[fg=#333333,bg=#222222]▌#[fg=white]#W "
set -g window-status-current-format "#[fg=#555555,bg=#555555] #[fg=white]#I#[fg=#11AADD]▐#[fg=#111111,bg=#11AADD]#W "
set -g status-right '#[fg=#888888]#($RCDIR/tmux/cpu.sh)  #($RCDIR/tmux/mem.sh) #[fg=#8899AA]#($RCDIR/tmux/time.sh)'
set -g status-left ''

#Keybinds
unbind-key -n C-a
unbind-key -n C-b
unbind-key C-a
unbind-key C-b
unbind-key a
set -g prefix ^Q
set -g prefix2 ^Q
bind q send-prefix

bind-key -n M-j next-window
bind-key -n M-k previous-window
bind-key -n M-h swap-window -t :-1 
bind-key -n M-l swap-window -t :+1 

bind-key -n M-1 select-window -t :1
bind-key -n M-2 select-window -t :2
bind-key -n M-3 select-window -t :3
bind-key -n M-4 select-window -t :4
bind-key -n M-5 select-window -t :5
bind-key -n M-6 select-window -t :6
bind-key -n M-7 select-window -t :7
bind-key -n M-8 select-window -t :8
bind-key -n M-9 select-window -t :9
bind-key -n M-0 select-window -t :10

bind-key x confirm-before kill-window

bind-key C-r source-file $HOME/.tmux.conf

bind-key k select-pane -U
bind-key j select-pane -D
bind-key h select-pane -L

bind-key l select-pane -R

bind-key C-c new-window
bind-key C-p previous-window
bind-key C-n next-window

bind-key C-k select-pane -U
bind-key C-j select-pane -D
bind-key C-h select-pane -L
bind-key C-l select-pane -R

bind-key C-q last-window

bind-key -n M-Left resize-pane -L
bind-key -n M-Right resize-pane -R
bind-key -n M-Up resize-pane -U
bind-key -n M-Down resize-pane -D
set -g renumber-windows

#Clipboard
bind y run "tmux show-buffer | xclip -i; tmux show-buffer | xclip -i -selection clipboard"
bind p run "tmux set-buffer -- \"$(xclip -o)\"; tmux paste-buffer"
bind C-v run "tmux set-buffer -- \"$(xclip -o -selection clipboard)\"; tmux paste-buffer"

#VIM!
set-window-option -g mode-keys vi
bind-key -t vi-copy 'v' begin-selection
bind-key -t vi-copy 'y' copy-selection
#bind-key -t vi-copy 'y' run "tmux show-buffer | xclip -i"
bind -t vi-copy Escape cancel

# Unbind bs
unbind-key '"'
bind-key | split-window
bind-key % split-window -h

unbind-key -n S-Left
unbind-key -n S-Up
unbind-key -n S-Right
unbind-key -n S-Down

unbind-key -n C-S-F2
unbind-key -n C-S-F3
unbind-key -n C-S-F4
unbind-key -n C-S-F5
unbind-key -n C-S-Left
unbind-key -n C-S-Right

unbind-key -n F1
unbind-key -n F2
unbind-key -n F3
unbind-key -n F4
unbind-key -n F6
unbind-key -n F7
unbind-key -n F8
unbind-key -n F9
unbind-key -n F10
unbind-key -n F11
unbind-key -n F12

# more stuff
set -g default-terminal "screen"
#set -g default-terminal "screen-256color"
set -g terminal-overrides 'xterm*:smcup@:rmcup@'
set -g default-command $SHELL
setw -g aggressive-resize on
set -g mode-mouse on
setw -g mouse-select-window on
setw -g mouse-select-pane on
set-option -g bell-action any
set-option -g bell-on-alert on
