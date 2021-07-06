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

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'

  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'
  use 'hrsh7th/nvim-compe'
end)


--------------------------------------------------
-- Neovim Options

local opt = vim.opt

-- Line number
opt.number = true
opt.relativenumber = true

-- Always display sign column
opt.signcolumn = 'yes'

-- Enable mouse support
opt.mouse = 'a'

-- Don't unload but instead hide buffers
opt.hidden = true

-- Keep a few lines visible around the cursor
opt.scrolloff = 2

-- Use 4 spaces instead of a tab
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
vim.cmd [[autocmd FileType lua setlocal shiftwidth=2 softtabstop=2]]

-- Search and substitute options
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'

-- Decrease update time
opt.updatetime = 250

-- Colorscheme
opt.termguicolors = true
opt.background = 'dark'
--vim.g.gruvbox_material_palette = 'original'
--vim.g.everforest_background = 'hard'
vim.cmd [[colorscheme sonokai]]


--------------------------------------------------
-- Mappings

vim.g.mapleader = " "

-- Window movements
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })


--------------------------------------------------
-- Tree-sitter

require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  playground = { enabled = true },
}


--------------------------------------------------
-- LSP Configs

require('lsp')
