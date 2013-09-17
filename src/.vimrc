" General

filetype plugin indent on
syntax on
scriptencoding utf-8

set virtualedit=onemore
set history=200

set nobackup
set nowritebackup

" UI

set term=xterm-256color
set background=dark
colorscheme solarized

set number " Line numbers on
set cursorline " Highlight current line

set showmatch " Show matching brackets/parenthesis
set hlsearch " Highlight search terms
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

set whichwrap+=<,>,h,l,[,]
set autoindent

au BufRead,BufNewFile *.jsm set filetype=javascript
au BufRead,BufNewFile *.rs,*.rc set filetype=rust
