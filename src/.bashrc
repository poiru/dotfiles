# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd

# Set a fancy prompt (non-color, unless we know we "want" color).
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir.
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\][\[$(tput setaf 2)\]\u\[$(tput sgr0)\]: \W]\$ ";;
               *) ;;
esac

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

export TERM=xterm-256color
export EDITOR=vim

# Alias definitions.
alias c=cd
alias g=git
alias h=hg
alias m=mv
alias s=sudo
alias v=vim

# Helpful functions.
function md() {
    [ -n "$1" ] && mkdir -p "$1" && cd "$1";
}
