--
-- lsp.lua

---@type LazySpec
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    lazy = false,
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- mason
  --  https://github.com/mason-org/mason.nvim
  --  Portable package manager for Neovim that runs everywhere Neovim runs.
  --  Easily install and manage LSP servers, DAP servers, linters, and formatters.
  {
    'mason-org/mason.nvim',
    lazy = false,
    opts = {},
  },

  -- mason-tool-installer
  --  https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  --  Install and upgrade third party tools automatically
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = false,
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
      ensure_installed = {
        -- lua
        'lua-language-server', -- lsp
        'stylua', -- formatter

        -- bash
        'bash-language-server', -- lsp
        'shfmt', -- formatter
      },
      -- auto_update = false, -- default: false
      -- run_on_start = true, -- default: true
    },
    config = function(_, opts)
      require('mason-tool-installer').setup(opts)

      vim.lsp.enable { 'lua-language-server', 'bash-language-server' }

      -- nvim builtin completion with LSP
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client:supports_method 'textDocument/completion' then
            vim.cmd [[set completeopt+=menuone,noselect,popup]]
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
          end
        end,
      })
    end,
  },

  { -- optional blink completion source for require statements and module annotations
    'saghen/blink.cmp',
    lazy = false,
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  },
}
