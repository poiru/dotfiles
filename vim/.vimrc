"
" General
"

set nocompatible

scriptencoding utf-8
set encoding=utf-8

set history=200

" Disable backups and swapfiles.
set nobackup
set nowritebackup
set noswapfile

set backspace=indent,eol,start

set viminfo=

"
" Formatting
"

set autoindent

"
" Visual
"

syntax on

set term=xterm-256color
set background=dark
colorscheme base16-tomorrow

" Disable cursor blinking entirely.
set guicursor+=a:blinkon0

" Show line numbers and highlight current line.
set number
set cursorline
set ruler

" Show matching brackets/parenthesis.
set showmatch

" Highlight search terms.
set hlsearch

" Highlight problematic whitespace
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

set pastetoggle=<F1>

" Allow left/right keys to wrap to previous/next line.
set whichwrap+=<,>,h,l,[,]

set virtualedit=block,onemore

"
" Mappings
"

map <C-q> {gq}

"
" Autocommands
"

au BufRead,BufNewFile *.cpp,*.h set et ts=2 sw=2
au BufRead,BufNewFile *.jsm set ft=javascript
au BufRead,BufNewFile *.pl set et ts=4 sw=4
au BufRead,BufNewFile *.rs,*.rc set ft=rust et ts=4 sw=4

filetype plugin indent on
