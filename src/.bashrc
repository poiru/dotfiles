# If this is an xterm set the title to user@host:dir.
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\][\[$(tput setaf 2)\]\u\[$(tput sgr0)\]: \W]\$ ";;
               *) ;;
esac

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
export PATH=$PATH:~/local/bin

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Alias definitions.
alias c=cd
alias cb='xclip -selection c'
alias g=git
alias h=hg
alias sr='screen -rD'
alias v=vim

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Helpful functions.
function md() {
    [ -n "$1" ] && mkdir -p "$1" && cd "$1";
}

# Enable programmable completion features.
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Enable color support for `ls` and others.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
fi

# Alias definitions (local only).
alias sk='ssh -t k screen -D -RR'
