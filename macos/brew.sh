#!/usr/bin/env bash

set -o errexit -o pipefail

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

brew install \
    bash \
    ccache \
    clang-format \
    coreutils \
    encfs \
    git \
    gnu-sed \
    homebrew/dupes/rsync \
    homebrew/versions/bash-completion2 \
    mercurial \
    python \
    ssh-copy-id \
    the_silver_searcher \
    tig \
    tree \
    unison \
    wget

brew cask install \
    dash \
    flux \
    imageoptim \
    iterm2 \
    karabiner-elements \
    keepassx \
    osxfuse \
    spectacle \
    sublime-text \
    vlc
