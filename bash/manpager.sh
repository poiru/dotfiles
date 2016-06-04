#!/bin/sh
export LESS_TERMCAP_md=$'\e[32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4m'
export LESS_TERMCAP_ue=$'\e[0m'
less <&0
