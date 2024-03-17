-- Map leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Editor UI
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.breakindent = true

-- Behavior
vim.opt.mouse = "a"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.sessionoptions:append("globals")

-- Editing
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1

-- Search and subtitute
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.inccommand = "split"

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- Window movements
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic message" })
vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, { desc = "Show [D]iagnostic messages" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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
  -- Color schemes
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        styles = {
          keywords = { bold = true, italic = false },
        },
        on_highlights = function(highlights, colors)
          highlights.Statement["bold"] = true
          highlights["@keyword.function"]["bold"] = true
          highlights.NeoTreeGitAdded = { fg = colors.green }
          highlights.NeoTreeGitModified = { fg = colors.blue }
          highlights.NeoTreeGitDeleted = { fg = colors.red }
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        styles = {
          conditionals = { "bold" },
          loops = { "bold" },
          keywords = { "bold" },
          miscs = {},
        },
      })
      -- vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        ---@diagnostic disable-next-line: missing-fields
        italic = {
          strings = false,
        },
        overrides = {
          SignColumn = { link = "Normal" },
          LspReferenceText = { link = "PmenuSbar" },
          LspReferenceRead = { link = "PmenuSbar" },
          LspReferenceWrite = { link = "PmenuSbar" },
        },
      })
      -- vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- Buffer line
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          offsets = {
            {
              filetype = "neo-tree",
              text = "Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
          close_command = function(bufnr)
            MiniBufremove.delete(bufnr, false)
          end,
          right_mouse_command = "",
          diagnostics = "nvim_lsp",
        },
      })

      vim.keymap.set("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
      vim.keymap.set("n", "L", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-Left>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
      vim.keymap.set("n", "<S-Right>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        section_separators = "",
        component_separators = "|",
      },
      extensions = { "lazy", "neo-tree" },
    },
  },

  -- TODO: nvim-navic

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    opts = {
      handle = {
        blend = 0,
      },
      handlers = {
        gitsigns = true,
      },
    },
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("neo-tree").setup({
        auto_clean_after_session_restore = true,
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_hidden = false,
            hide_by_name = { ".git" },
          },
        },
      })
      -- TODO: document_symbols

      vim.keymap.set("n", "<Leader>e", function()
        require("neo-tree.command").execute({ toggle = true })
      end, { desc = "Toggle [E]xplorer" })
    end,
  },

  -- Which Key
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()

      require("which-key").register({
        ["<Leader>s"] = { name = "+[S]earch" },
      })
    end,
  },

  -- TODO: trouble.nvim?

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "▏" },
      scope = { enabled = false },
    },
  },

  -- mini.nvim
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })

      require("mini.bufremove").setup()
      vim.keymap.set("n", "<Leader>bd", function()
        MiniBufremove.delete(0, false)
      end, { desc = "[B]uffer [D]elete" })

      require("mini.comment").setup()

      require("mini.pairs").setup()

      require("mini.surround").setup()

      -- TODO: mini.sessions?
    end,
  },

  -- Session management
  {
    "folke/persistence.nvim",
    config = function()
      require("persistence").setup({
        options = vim.opt.sessionoptions:get(),
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
        callback = function()
          require("persistence").load()
        end,
        nested = true,
      })
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("telescope").setup({})
      pcall(require("telescope").load_extension, "fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<Leader>/", builtin.live_grep, { desc = "[/] Search by Grep" })
      vim.keymap.set("n", "<Leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    end,
  },

  -- Tree sitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = ":TSUpdate",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "lua",
          "make",
          "markdown",
          "python",
          "query",
          "rust",
          "toml",
          "vim",
          "vimdoc",
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-Space>",
            node_incremental = "<C-Space>",
            scope_incremental = false,
            node_decremental = "<BS>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
        },
      })

      vim.opt.foldlevel = 99
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "folke/neodev.nvim",
        opts = {
          override = function(_, library)
            library.enabled = true
          end,
        },
      },
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
        callback = function(event)
          local function map(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("n", "gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          map("n", "gy", require("telescope.builtin").lsp_type_definitions, "[G]oto t[y]pe definition")
          map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
          map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

          map("n", "<Leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("n", "<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
          map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls", "pyright", "rust_analyzer" },
      })
      -- + stylua

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      local lspconfig = require("lspconfig")

      lspconfig.clangd.setup({ capabilities = capabilities })

      lspconfig.lua_ls.setup({ capabilities = capabilities })

      lspconfig.pyright.setup({ capabilities = capabilities })

      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
    end,
  },

  -- TODO: rustaceanvim

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has("win32") == 0 and vim.fn.executable("make") == 1 then
            return "make install_jsregexp"
          end
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup()
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = require("lspkind").cmp_format({ mode = "symbol" }),
        },
      })
    end,
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
        formatters_by_ft = {
          lua = { "stylua" },
        },
      })

      vim.opt.formatexpr = "v:lua.require('conform').formatexpr()"
    end,
  },
})

-- vim: shiftwidth=2
