# Bail out if this is a non-interactive shell.
if [ -z "$PS1" ]; then
   return
fi

shopt -s checkwinsize
shopt -s histappend
shopt -u hostcomplete

if (( BASH_VERSINFO[0] >= 4 )); then
    shopt -s checkjobs
    shopt -s globstar
fi

printf -v LS_COLORS '%s:' \
    'rs=0' \
    'di=34' \
    'ln=35' \
    'pi=33' \
    'so=35' \
    'do=35' \
    'bd=33;4' \
    'cd=33;4' \
    'or=35;4' \
    'su=32;4' \
    'sg=32;4' \
    'tw=36;4' \
    'ow=34;4' \
    'st=36' \
    'ex=31'
export LS_COLORS

export EDITOR=vim

export LESS=nRK
export LESSHISTFILE=/dev/null

export MANPAGER="~/.manpager"

export PATH=$PATH:$HOME/.cargo/bin:~/local/bin
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=/opt/homebrew/bin:$PATH
fi

# Change prompt to:
#   [user: dir]
#   $
case "$TERM" in
    screen|xterm*)
        PS1="\[\e]0;\u@\h: \W\a\]"
        PS1+="\[\e[1;30m\]["
        PS1+="\[\e[0;32m\]\u"
        if [ -n "$SSH_CLIENT" ]; then
            PS1+="@\h"
        fi
        PS1+="\[\e[1;30m\]: \w]\n\$ \[\e[0m\]"
        ;;
esac

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000

unset MAILCHECK

# Disable flow control (CTRL+S/CTRL+Q).
stty -ixon

# Alias definitions.
alias adu='sudo apt-get update &&
           sudo apt-get dist-upgrade &&
           sudo apt-get autoremove'
alias c=cd
alias g=git
alias h=hg
alias m='MOZ_QUIET=1 ./mach'
alias s=subl
alias sr='screen -rD'
alias sk='ssh -t k screen -D -RR; clear'
alias v=vim

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

if [[ "$OSTYPE" == "darwin"* ]]; then
    alias cb='pbcopy'
    alias ls='gls --color=auto'
    alias o=open
    alias t=trash
else
    alias cb='xclip -selection c'
    alias ls='ls --color=auto'
    alias o=xdg-open
fi

alias C='set -f -B; _calc '
function _calc() {
    echo "scale=5; $@" | tr -d ', \042-\047' | bc -l;
    set +f;
}

# Helpful functions.
function f() {
    find . \
        -not '(' -type d -name '.git' -prune ')' \
        -not '(' -type d -name '.hg' -prune ')' \
        -not '(' -type d -name 'obj-*' -prune ')' \
        $@
}

function function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

function md() {
    [ -n "$1" ] && mkdir -p "$1" && cd "$1";
}

function sourceif() {
    for f in $@; do
        if [ -f "$f" ]; then
            . "$f"
            return;
        fi
    done

    echo "sourceif: Not found: '$@'"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    sourceif /opt/homebrew/etc/profile.d/bash_completion.sh
fi

# Make auto-completion work for names with colons.
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

# Make auto-completion work with a few aliases.
if function_exists "_comp_load"; then
    _comp_load cd
    complete -F _comp_cmd_cd -o nospace c

    if function_exists "__git_complete"; then
        __git_complete g __git_main
    fi
fi
