set -o vi
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# When in command mode, keep the cursor at the end of the line when using the
# up/down arrows.
bind -m vi-command '"\201": previous-history'
bind -m vi-command '"\202": next-history'
bind -m vi-command '"\203": end-of-line'
bind -m vi-command '"\e[A": "\201\203"'
bind -m vi-command '"\e[B": "\202\203"'

export EDITOR=vim

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Alias definitions.
alias c=cd
alias g=git
alias h=hg
alias m=mv
alias s=sudo
alias sr='screen -rD'
alias v=vim

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Helpful functions.
function md() {
    [ -n "$1" ] && mkdir -p "$1" && cd "$1";
}