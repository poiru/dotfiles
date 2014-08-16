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
alias g=git
alias h=hg
alias sr='screen -rD'
alias sk='ssh -t k screen -D -RR'
alias v=vim

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cb='xclip -selection c'
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias cb='pbcopy'
fi

# Helpful functions.
function extract() {
    case $1 in
        *.tar)     tar xvf $1;;
        *.tar.bz2) tar xvjf $1;;
        *.tbz2)    tar xvjf $1;;
        *.tar.gz)  tar xvzf $1;;
        *.tgz)     tar xvzf $1;;
        *.tar.xz)  tar xvJf $1;;
        *.lzma)    unlzma $1;;
        *.bz2)     bunzip2 $1;;
        *.rar)     unrar x -ad $1;;
        *.gz)      gunzip $1;;
        *.zip)     unzip $1;;
        *.7z)      7z x $1;;
        *.xz)      unxz $1;;
        *)         echo "extract: Invalid file: '$1'";;
    esac
}

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
    elif [ -f /usr/local/share/bash-completion/bash_completion ]; then
        . /usr/local/share/bash-completion/bash_completion
    fi

    # Explicitly load the useful completion scripts.
    for i in git mercurial; do
        i=/etc/bash_completion.d/$i
        [[ -f $i && -r $i ]] && . "$i"
    done

    # Enable auto-completion for the 'g' alias.
    type __git_complete >/dev/null && __git_complete g __git_main
fi

# Enable color support for `ls` and others.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
fi
