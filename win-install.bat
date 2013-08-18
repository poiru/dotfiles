@echo off

set src=%~dp0src
mklink "%USERPROFILE%\.gitconfig" "%src%\.gitconfig"
mklink "%USERPROFILE%\.hgrc" "%src%\.hgrc"