@echo off

set script_dir=%~dp0
mklink "%USERPROFILE%\.gitconfig" "%script_dir%git\.gitconfig"
mklink "%USERPROFILE%\.hgrc" "%script_dir%hg\.hgrc"