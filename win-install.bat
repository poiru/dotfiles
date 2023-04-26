@echo off

set script_dir=%~dp0
mklink "%USERPROFILE%\.gitconfig" "%script_dir%git\.gitconfig"
