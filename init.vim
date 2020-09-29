""""""""""""""""""""""""""""""""""""""""""""""""""
" kjh's init.vim


""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug Plugins

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""
" Other Configs

syntax on
filetype plugin indent on

" Mouse support
set mouse=a


""""""""""""""""""""""""""""""""""""""""""""""""""
" UI

" Line number
set number


""""""""""""""""""""""""""""""""""""""""""""""""""
" Editor

" Use four spaces instead of a tab
set shiftwidth=4
set softtabstop=4
set expandtab

" Search
set ignorecase
set smartcase

" Don't unload but instead hide a buffer
set hidden

