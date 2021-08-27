--------------------------------------------------
-- Mappings

vim.g.mapleader = " "

-- Window movements
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- Yank all to clipboard
-- vim.api.nvim_set_keymap('n', '<Leader>ya', '<Cmd>%y+<CR>', { noremap = true })
