# If this is an xterm set the title to user@host:dir.
case "$TERM" in
    xterm*) PS1="\[\e]0;\u@\h: \w\a\][\[$(tput setaf 2)\]\u\[$(tput sgr0)\]: \W]\$ ";;
    screen) PS1="\[\e]0;\u@\h (screen): \w\a\][\[$(tput setaf 2)\]\u\[$(tput sgr0)\]: \W]\$ ";;
    *) ;;
esac

set -o vi
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

# Disable flow control (CTRL+S/CTRL+Q).
stty -ixon

# When in command mode, keep the cursor at the end of the line when using the
# up/down arrows.
bind -m vi-command '"\201": previous-history'
bind -m vi-command '"\202": next-history'
bind -m vi-command '"\203": end-of-line'
bind -m vi-command '"\e[A": "\201\203"'
bind -m vi-command '"\e[B": "\202\203"'

export EDITOR=vim

export PATH=$PATH:~/local/bin
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=/usr/local/bin:$PATH
fi

# Alias definitions.
alias adu='sudo apt-get update &&
           sudo apt-get dist-upgrade &&
           sudo apt-get autoremove'
alias c=cd
alias cb='xclip -selection c'
alias g=git
alias h=hg
alias sr='screen -rD'
alias sk='ssh -t k screen -D -RR'
alias v=vim

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Helpful functions.
function md() {
    [ -n "$1" ] && mkdir -p "$1" && cd "$1";
}

# Enable auto-completion.
if ! shopt -oq posix; then
    # To speed up bash initialization, this is set to a non-existent directory
    # to avoid loading all the useless completion scripts found in
    # /etc/bash_completion.d/.
    if [ -z "${BASH_COMPLETION_COMPAT_DIR}" ]; then
        BASH_COMPLETION_COMPAT_DIR="/none"
    fi

    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    elif [ -f /usr/local/etc/bash_completion ]; then
        . /usr/local/etc/bash_completion
    fi

    # Explicitly load the useful completion scripts.
    for i in git mercurial; do
        i=/etc/bash_completion.d/$i
        [[ -f $i && -r $i ]] && . "$i"
    done
fi

# Enable color support for `ls` and others.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
fi
