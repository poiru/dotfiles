# Bail out if this is a non-interactive shell.
if [ -z "$PS1" ]; then
   return
fi

# If this is an xterm set the title to user@host:dir.
case "$TERM" in
    xterm*) PS1="\[\e]0;\u@\h: \w\a\][\[$(tput setaf 2)\]\u\[$(tput sgr0)\]: \W]\$ ";;
    screen) PS1="\[\e]0;\u@\h (screen): \w\a\][\[$(tput setaf 2)\]\u\[$(tput sgr0)\]: \W]\$ ";;
    *) ;;
esac

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
export LESS=nR

export LS_COLORS='rs=0:di=34:ln=35:mh=00:pi=33:so=35:do=35:bd=33;04:cd=33;04:or=35;04:su=32;04:sg=32;04:ca=30;41:tw=36;04:ow=34;04:st=36:ex=31:'

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
alias m='MOZ_QUIET=1 ./mach'
alias sr='screen -rD'
alias sk='ssh -t k screen -D -RR; clear'
alias v=vim

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cb='xclip -selection c'
alias ls='ls --color=auto'
alias o=xdg-open
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias cb='pbcopy'
    alias ls='gls --color=auto'
    alias o=open
fi

alias C='set -f -B; _calc '
function _calc() {
    echo "scale=5; $@" | tr -d ', \042-\047' | bc -l;
    set +f;
}

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

# Enable auto-completion.
if ! shopt -oq posix; then
    # To speed up bash initialization, this is set to a non-existent directory
    # to avoid loading all the useless completion scripts found in
    # /etc/bash_completion.d/.
    if [ -z "${BASH_COMPLETION_COMPAT_DIR}" ]; then
        BASH_COMPLETION_COMPAT_DIR="/none"
    fi

    sourceif /usr/share/bash-completion/bash_completion \
             /etc/bash_completion \
             /usr/local/share/bash-completion/bash_completion

    # Make auto-completion work with some aliases.
    function _custom_completion_loader() {
        local cmd=$1
        case $cmd in
            g|git)
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    . /usr/local/etc/bash_completion.d/git-completion.bash
                elif [ -f "/etc/bash_completion.d/git" ]; then
                    . /etc/bash_completion.d/git
                else
                    _completion_loader git
                fi

                if function_exists "__git_complete"; then
                    __git_complete g __git_main
                else
                    complete -o bashdefault -o default -o nospace -F _git g
                fi
                ;;
            h|hg)
                sourceif /etc/bash_completion.d/mercurial \
                         /usr/local/etc/bash_completion.d/hg-completion.bash
                complete -o bashdefault -o default -o nospace -F _hg h
                ;;
            *)
                _completion_loader $cmd
                ;;
        esac

        return 124
    }

    if function_exists "_completion_loader"; then
        complete -D -F _custom_completion_loader
    fi

    complete -F _cd -o nospace c
fi

# Make auto-completion work for names with colons.
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
