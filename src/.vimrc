" General

filetype plugin indent on
syntax on
scriptencoding utf-8

set virtualedit=onemore
set history=200

" UI

set background=dark
colorscheme solarized

set number " Line numbers on
set cursorline " Highlight current line

set showmatch " Show matching brackets/parenthesis
set hlsearch " Highlight search terms
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

au BufRead,BufNewFile *.jsm setfiletype javascript

set whichwrap+=<,>,h,l,[,]
set autoindent
