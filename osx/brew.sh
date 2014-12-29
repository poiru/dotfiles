#!/usr/bin/env bash

set -o errexit -o pipefail

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew tap homebrew/versions

brew install \
    bash \
    bash-completion2 \
    ccache \
    coreutils \
    git \
    gnu-sed \
    mercurial \
    ssh-copy-id \
    the_silver_searcher \
    tmux \
    tree \
    wget
