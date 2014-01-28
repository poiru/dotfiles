syntax on
scriptencoding utf-8

filetype plugin indent on

set virtualedit=onemore
set history=200

" Disable backups and swapfiles.
set nobackup
set nowritebackup
set noswapfile

" Solarized theme.
set term=xterm-256color
set background=dark
let g:solarized_menu=0
colorscheme solarized

set guicursor+=a:blinkon0

" Show line numbers and highlight current line.
set number
set cursorline

" Show matching brackets/parenthesis.
set showmatch

" Highlight search terms.
set hlsearch

" Highlight problematic whitespace
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

set whichwrap+=<,>,h,l,[,]
set autoindent

set pastetoggle=<F1>

au BufRead,BufNewFile *.cpp,*.h set et ts=2 sw=2
au BufRead,BufNewFile *.jsm set filetype=javascript
au BufRead,BufNewFile *.pl set et ts=4 sw=4
au BufRead,BufNewFile *.rs,*.rc set filetype=rust et ts=4 sw=4
