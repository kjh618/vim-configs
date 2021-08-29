--------------------------------------------------
-- kjh's init.lua


--------------------------------------------------
-- Packer

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Colorschemes
  use 'sainnhe/sonokai'
  use 'sainnhe/gruvbox-material'
  use 'sainnhe/everforest'
  use 'navarasu/onedark.nvim'
  -- use 'arcticicestudio/nord-vim'
  -- use 'NTBBloodbath/doom-one.nvim'
  -- use 'liuchengxu/space-vim-theme'
  -- use 'tyrannicaltoucan/vim-deep-space'

  -- UI
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'dstein64/nvim-scrollview'
  use { 'hoob3rt/lualine.nvim', requires = { { 'kyazdani42/nvim-web-devicons', opt = true } } }

  use 'folke/which-key.nvim'
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Text Editing
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
end)


--------------------------------------------------
-- Neovim Options

local opt = vim.opt


-- UI

-- Line number
opt.number = true
opt.relativenumber = true

-- Keep a few lines visible around the cursor
opt.scrolloff = 2

-- Split positions
opt.splitbelow = true
opt.splitright = true

-- Other UI options
-- opt.foldcolumn = '1'
opt.signcolumn = 'yes'
opt.showmode = false

-- Colorscheme
opt.termguicolors = true
opt.background = 'dark'
-- vim.g.gruvbox_material_palette = 'original'
-- vim.g.everforest_background = 'hard'
vim.cmd [[colorscheme sonokai]]
vim.cmd [[
  augroup colorscheme_colors
    autocmd!
    autocmd ColorScheme sonokai highlight! link TSPunctBracket Fg | highlight! link TSPunctDelimiter Fg
  augroup end
]]


-- Behavior

-- Enable mouse support
opt.mouse = 'a'

-- Don't unload but instead hide buffers
opt.hidden = true

-- Persistent undo
opt.undofile = true

-- Decrease update time
opt.updatetime = 250

-- Decrease mapping timeout length
opt.timeoutlen = 500


-- Text Editing

-- Use 4 spaces instead of a tab
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
vim.cmd [[
  augroup file_type_indentation
    autocmd!
    autocmd FileType lua setlocal shiftwidth=2 softtabstop=2
  augroup end
]]

-- Search and substitute options
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'

-- Highlighted yank
vim.cmd [[
  augroup highlighted_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]


--------------------------------------------------
-- Mappings

require('mappings')


--------------------------------------------------
-- File Explorer

vim.g.nvim_tree_ignore = { '.git' }
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_icons = { default = '' }

vim.cmd [[
  augroup nvim_tree_colors
    autocmd!
    autocmd VimEnter * highlight! link NvimTreeLspDiagnosticsError LspDiagnosticsSignError
    autocmd VimEnter * highlight! link NvimTreeLspDiagnosticsWarning LspDiagnosticsSignWarning
    autocmd VimEnter * highlight! link NvimTreeLspDiagnosticsInformation LspDiagnosticsSignInformation
    autocmd VimEnter * highlight! link NvimTreeLspDiagnosticsHint LspDiagnosticsSignHint
  augroup end
]]

vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', { noremap = true })


--------------------------------------------------
-- Gitsigns

require('gitsigns').setup {
  keymaps = {}
}


--------------------------------------------------
-- Statusline

local lualine_utils = require('lualine.utils.utils')
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'material',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        color_error = lualine_utils.extract_highlight_colors('LspDiagnosticsSignError', 'fg'),
        color_warn = lualine_utils.extract_highlight_colors('LspDiagnosticsSignWarning', 'fg'),
        color_info = lualine_utils.extract_highlight_colors('LspDiagnosticsSignInformation', 'fg'),
        color_hint = lualine_utils.extract_highlight_colors('LspDiagnosticsSignHint', 'fg'),
        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
      },
    },
    lualine_x = { { 'filetype', colored = false } },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  extensions = { 'nvim-tree' }
}


--------------------------------------------------
-- Which Key

require('which-key').setup {}

--------------------------------------------------
-- Telescope

vim.api.nvim_set_keymap('n', '<Leader>ff', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', [[<Cmd>lua require('telescope.builtin').live_grep()<Cr>]], { noremap = true })


--------------------------------------------------
-- Treesitter

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'lua', 'query', 'comment',
    'c', 'rust', 'toml', 'python',
    'bash',
    'html', 'css', 'javascript',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {
      python = true,
    },
  },
  playground = {
    enabled = true,
  },
}

-- Fold options
opt.foldlevelstart = 99
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'


--------------------------------------------------
-- LSP Configs

require('lsp')
