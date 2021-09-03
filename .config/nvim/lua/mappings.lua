--------------------------------------------------
-- Mappings

vim.g.mapleader = " "

-- Future defaults
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Keep selection when indenting
vim.api.nvim_set_keymap('x', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('x', '>', '>gv', { noremap = true })

-- Window movements
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- Stop highlighting search
vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>nohlsearch<CR>', { noremap = true })

-- Yank/put to clipboard
vim.api.nvim_set_keymap('', '<Leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('', '<Leader>p', '"+p', { noremap = true })
