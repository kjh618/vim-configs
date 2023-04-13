--------------------------------------------------
-- Plugins

-- Map leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    "tpope/vim-surround",
    "tpope/vim-commentary",
})

--------------------------------------------------
-- Options

-- UI
vim.opt.termguicolors = true
vim.cmd [[language en_US.UTF-8]]
vim.opt.number = true

-- Behavior
vim.opt.mouse = "a"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.scrolloff = 2

-- Search
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Use 4 spaces instead of a tab
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Highlight on yank
local highlight_on_yank = vim.api.nvim_create_augroup("HighlightOnYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_on_yank,
    pattern = "*",
    callback = function() vim.highlight.on_yank() end,
})

--------------------------------------------------
-- Mappings

-- Window movements
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
