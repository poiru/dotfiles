# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

. ~/.bash_profile

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