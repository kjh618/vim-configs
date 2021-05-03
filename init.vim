""""""""""""""""""""""""""""""""""""""""""""""""""
" kjh's init.vim


""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug Plugins {{{

call plug#begin(stdpath('data') . '/plugged')

Plug 'gruvbox-community/gruvbox'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'itchyny/lightline.vim'

Plug 'machakann/vim-highlightedyank'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'rust-lang/rust.vim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'jackguo380/vim-lsp-cxx-highlight'

call plug#end()

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim Options {{{

" Line number
set number

" Mouse support
set mouse=a

" Keep a few lines visible around the cursor
set scrolloff=2

" Don't unload but instead hide a buffer
set hidden

" Use four spaces instead of a tab
set expandtab
set shiftwidth=4
set softtabstop=4

" Search
set ignorecase
set smartcase

" Folding
set foldmethod=syntax
set foldlevelstart=99
set foldcolumn=2
autocmd FileType vim set foldmethod=marker

" Window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use C syntax highlihting for *.h files
let c_syntax_for_h = 1

" Leader key
let mapleader = " "

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme {{{

set termguicolors
set background=dark

let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 0
let g:gruvbox_invert_selection = 0
colorscheme gruvbox

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree {{{

nnoremap <leader>n :NERDTreeToggle<CR>

let NERDTreeShowHidden = 1
let NERDTreeIgnore = [ '^\.git$[[dir]]', '\.o$[[file]]' ]

let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusConcealBrackets = 1

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline.vim  {{{

" Don't show the mode in the last line
set noshowmode

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:lightline = {
  \   'colorscheme': 'gruvbox',
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['readonly', 'filename', 'modified'],
  \       ['cocstatus'],
  \     ],
  \     'right': [
  \       ['lineinfo'],
  \       ['percent'],
  \       ['filetype'],
  \     ],
  \   },
  \   'inactive': {
  \     'left': [
  \       ['filename', 'modified']
  \     ],
  \   },
  \   'component_function': {
  \     'cocstatus': 'coc#status',
  \   },
  \ }

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-highlightedyank {{{

let g:highlightedyank_highlight_duration = 200

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf {{{

nnoremap <leader>p :GFiles --cached --others --exclude-standard<CR>

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim {{{

" From Readme.md
source coc.vim

" Change coc-rust-analyzer type hint color
highlight! link CocRustTypeHint Comment
highlight! link CocRustChainingHint Comment

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-lsp-cxx-highlight {{{

" Remove highlighting for struct fields
autocmd User CocNvimInit highlight LspCxxHlGroupMemberVariable ctermfg=NONE guifg=NONE

" }}}
