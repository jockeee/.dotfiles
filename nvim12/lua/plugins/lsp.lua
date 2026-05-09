--
-- plugins/lsp.lua

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
})

require('mason').setup()

-- define servers to use
-- override config settings provided by `nvim-lspconfig` and files in lsp/
local servers = {
  lua_ls = {
    settings = {
      -- https://luals.github.io/wiki/settings
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = {
          disable = { 'missing-fields' }, -- Ignore Lua_LS's noisy `missing-fields` warnings
        },
        format = {
          enable = false,
        },
        hint = {
          enable = true, -- inlay hints
        },
      },
    },
  },

  bashls = {},
  fish_lsp = {},

  ruff = {}, -- python

  jsonls = {},
  yamlls = {},

  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        completeUnimported = false,
        staticcheck = true,
        gofumpt = true,
      },
      templateExtensions = { 'tmpl' },
    },
  },

  ols = {}, -- odin
}

local tools = {
  -- lua
  'stylua', -- formatter

  -- bash
  'shfmt', -- formatter
  'shellcheck', -- linter

  -- go
  'gofumpt', -- formatter, a stricter gofmt
  'goimports-reviser', -- formatter, sorts goimports by 3-4 groups (stdlib, general, company, project dependencies)
  'staticcheck', -- linter
  'delve', -- dap, debugger

  -- sql
  'sqlfluff', -- formatter and linter

  -- xml
  'xmlformatter',
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, tools)
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for server, config in pairs(servers) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
