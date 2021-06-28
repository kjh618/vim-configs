" kjh's .vimrc

" TODO: Change to Neovim defaults

set nocompatible

filetype plugin indent on
syntax enable

" UI
set number
set wildmenu
set laststatus=2
set ruler
set showcmd
set background=dark

" Behavior
set mouse=a
set history=1000
set ttimeout
set ttimeoutlen=100
set encoding=utf-8
set sessionoptions-=options
set viewoptions-=options

" Editor UI
set scrolloff=2
set display+=lastline
set listchars=tab:>\ ,trail:-,nbsp:+

" Editor Behavior
set backspace=indent,eol,start
set hidden
set autoread
set nrformats-=octal
set formatoptions+=j

" Indentation
set autoindent
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Plugins
packadd! matchit
