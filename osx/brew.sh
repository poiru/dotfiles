#!/usr/bin/env bash

set -o errexit -o pipefail

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

brew install \
    bash \
    bash-completion2 \
    ccache \
    clang-format \
    coreutils \
    git \
    gnu-sed \
    mercurial \
    rsync \
    ssh-copy-id \
    the_silver_searcher \
    tmux \
    tig \
    trash \
    tree \
    unison \
    wget
