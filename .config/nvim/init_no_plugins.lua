--------------------------------------------------
-- kjh's init.lua with no plugins


--------------------------------------------------
-- Neovim Options


-- UI

-- Line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Keep a few lines visible around the cursor
vim.opt.scrolloff = 2

-- Split positions
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Colors
vim.opt.termguicolors = true

-- Language
vim.cmd [[language en_US.UTF-8]]


-- Behavior

-- Enable mouse support
vim.opt.mouse = 'a'

-- Persistent undo
vim.opt.undofile = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapping timeout length
vim.opt.timeoutlen = 500


-- Text Editing

-- Use 4 spaces instead of a tab
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.cmd [[
  augroup file_type_indentation
    autocmd!
    autocmd FileType lua setlocal shiftwidth=2 softtabstop=2
  augroup end
]]

-- Search and substitute options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'nosplit'

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
