--------------------------------------------------
-- LSP Configs

local lspconfig = require('lspconfig')

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end


--------------------------------------------------
-- Lua

local sumneko_lua_path = vim.fn.getenv("HOME") .. "/.local/bin/vscode-lua/extension/server/"
lspconfig.sumneko_lua.setup {
  cmd = { sumneko_lua_path .. "bin/Linux/lua-language-server", '-E', sumneko_lua_path .. 'main.lua' },
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          vim.fn.expand('$VIMRUNTIME/lua'),
          vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
        },
      },
    },
  },
}


--------------------------------------------------
-- Rust

require('rust-tools').setup()


--------------------------------------------------
-- Compe

vim.opt.completeopt = 'menuone,noselect'
vim.opt.shortmess:append('c')

require('compe').setup {
  source = {
    path = true,
    nvim_lsp = true,
  },
}

vim.api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })
