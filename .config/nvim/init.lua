--------------------------------------------------
-- kjh's init.lua


--------------------------------------------------
-- Packer

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'navarasu/onedark.nvim'
  use 'sainnhe/gruvbox-material'
  use 'sainnhe/everforest'
  use 'sainnhe/sonokai'
  use 'arcticicestudio/nord-vim'
  use 'NTBBloodbath/doom-one.nvim'
  use 'liuchengxu/space-vim-theme'
  use 'tyrannicaltoucan/vim-deep-space'

  use 'preservim/nerdtree'
  use 'itchyny/lightline.vim'
  use 'dstein64/nvim-scrollview'
  use 'folke/which-key.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'

  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'
  use 'hrsh7th/nvim-compe'
end)


--------------------------------------------------
-- Neovim Options

local opt = vim.opt

-- Enable mouse support
opt.mouse = 'a'

-- UI options
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.foldcolumn = '1'
opt.showmode = false

-- Use 4 spaces instead of a tab
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
vim.cmd [[autocmd FileType lua setlocal shiftwidth=2 softtabstop=2]]

-- Search and substitute options
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'

-- Persistent undo
opt.undofile = true

-- Don't unload but instead hide buffers
opt.hidden = true

-- Decrease update time
opt.updatetime = 250

-- Decrease timeoutlen
opt.timeoutlen = 500

-- Keep a few lines visible around the cursor
opt.scrolloff = 2

-- Highlight on yank
vim.cmd [[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]


--------------------------------------------------
-- Mappings

vim.g.mapleader = " "

-- Window movements
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })


--------------------------------------------------
-- Colorscheme

opt.termguicolors = true
opt.background = 'dark'

--vim.g.gruvbox_material_palette = 'original'
--vim.g.everforest_background = 'hard'
vim.cmd [[colorscheme onedark]]


--------------------------------------------------
-- NERDTree

vim.g.NERDTreeShowHidden = 1

vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>NERDTreeToggle<CR>', { noremap = true })


--------------------------------------------------
-- Lightline

vim.g.lightline = {
  colorscheme = 'one',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'readonly', 'filename', 'modified' },
    },
    right = {
      { 'lineinfo' },
      { 'percent' },
      { 'filetype' },
    },
  },
  inactive = {
    left = {
      { 'filename', 'modified' },
    },
  },
}


--------------------------------------------------
-- Which Key

require('which-key').setup {}


--------------------------------------------------
-- Tree-sitter

require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  playground = { enabled = true },
}

-- Fold options
opt.foldlevelstart = 99
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'


--------------------------------------------------
-- LSP Configs

require('lsp')
