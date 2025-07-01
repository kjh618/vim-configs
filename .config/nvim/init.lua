-- TODO: Add mappings

-- Map leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard
vim.g.clipboard = vim.g.vscode_clipboard

-- UI
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.laststatus = 3

-- Editor UI
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.breakindent = true

-- Behavior
vim.opt.mouse = "a"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"

-- Editing
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1

-- Search and subtitute
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- Motions
vim.keymap.set("n", "j", "gj", { remap = true, desc = "Move down" })
vim.keymap.set("n", "k", "gk", { remap = true, desc = "Move up" })

-- Window movements
vim.keymap.set("n", "<C-h>", "<C-w>h", { remap = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { remap = true, desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { remap = true, desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { remap = true, desc = "Move to right window" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- mini.nvim
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()
    end,
  },
})
