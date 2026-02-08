--
-- lua/plugin/lsp.lua

---@type LazySpec
return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      {
        'folke/lazydev.nvim',
        lazy = false,
        priority = 1000,
        dependencies = {
          -- WezTerm Lua config types for Lua Language Server
          {
            'DrKJeff16/wezterm-types',
            lazy = false,
            priority = 1000,
            version = false, -- Get the latest version
          },
        },
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } }, -- Load luvit types when the `vim.uv` word is found
            { path = 'wezterm-types', mods = { 'wezterm' } }, -- Load wezterm types when the `wezterm` module is required
          },
        },
      },
    },
    opts = {},
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()

      -- define servers to use
      -- override config settings provided by `nvim-lspconfig` and files in lsp/
      local servers = {
        -- ansible
        ansiblels = {},

        -- bash
        bashls = {},

        -- fish
        fish_lsp = {}, -- ndonfris/fish-lsp

        -- lua
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

        -- go
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

        -- python
        ruff = {},

        -- web

        -- css
        cssls = {}, -- microsoft/vscode-css-languageservice
        css_variables = {}, -- vunguyentuan/vscode-css-variables, autocompletion and go-to-definition for project-wide CSS variables.
        tailwindcss = {
          filetypes = { 'html', 'javascript', 'php' },
        },

        -- html
        -- superhtml = { -- kristoff-it/superhtml
        --   filetypes = { 'html' },
        -- },
        html = { -- microsoft/vscode-html-languageservice
          filetypes = { 'html', 'template', 'templ' },
        },

        -- js
        --
        -- Summary Table:
        -- | Feature                | Biome LSP | typescript-language-server |
        -- |------------------------|-----------|----------------------------|
        -- | Linting                | ✅        | ❌ (use ESLint)            |
        -- | Formatting             | ✅        | ❌                         |
        -- | Hover, K               | ❌        | ✅                         |
        -- | Go to Definition       | ❌        | ✅                         |
        -- | Autocomplete           | ❌        | ✅                         |

        -- biome
        biome = {
          filetypes = (function()
            return vim.tbl_filter(function(ft)
              return ft ~= 'css'
            end, vim.lsp.config['biome'].filetypes or {})
          end)(),
          -- root_dir = nil,
          -- root_markers = { '.git', 'package.json', 'biome.json', 'biome.jsonc' },
          workspace_required = false,
        },

        -- typescript-language-server, ts_ls
        ts_ls = {
          single_file_support = true,
        },

        -- eslint-lsp
        --  https://github.com/Microsoft/vscode-eslint
        --  The server uses the ESLint library installed in the opened workspace folder.
        --  If the folder doesn't provide one the extension looks for a global install version.
        --[[ eslint = {}, ]]
        -- biome
        --  nvim-lspconfig default config for biome respects eslint/prettier projects.
        --  = requires `biome.json` or `biome.jsonc` in project root or biome won't attach.
        --  `cmd` use projects biome verion, fallback global install.
        -- biome = {},

        -- emmet
        --  aca/emmet-ls
        emmet_ls = {
          filetypes = { 'html', 'css', 'javascript', 'php' },
          -- init_options = {
          --   html = {
          --     options = {
          --       -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          --       ['bem.enabled'] = true,
          --     },
          --   },
          -- },
        },

        -- json
        jsonls = {},

        -- php
        -- phpactor = {
        --   init_options = {
        --     language_server_phpstan = {
        --       enabled = true,
        --       -- path = "/usr/local/bin/phpstan", -- custom path if needed
        --       -- level = 5, -- phpstan level (0-8)
        --       -- configuration = "/path/to/phpstan.neon", -- custom config file
        --     },
        --     language_server_psalm = {
        --       enabled = false,
        --     },
        --     -- Enable completion for global symbols
        --     completion = {
        --       global_symbols = true,
        --     },
        --     -- Enable file rename refactoring
        --     file_rename = {
        --       enabled = true,
        --     },
        --     -- Enable code lens features
        --     code_lens = {
        --       enabled = true,
        --     },
        --     -- Enable diagnostics
        --     diagnostics = {
        --       enabled = true,
        --     },
        --     -- Enable formatting
        --     formatting = {
        --       enabled = true,
        --     },
        --   },
        -- },
        intelephense = {
          settings = {
            intelephense = {
              telemetry = { enabled = false },
              diagnostics = { enable = false },
            },
          },
        },
      }

      local tools = {
        -- ansible
        'ansible-lint',

        -- bash
        'shfmt', -- formatter
        'shellcheck', -- linter

        -- go
        'gofumpt', -- formatter, a stricter gofmt
        'goimports-reviser', -- formatter, sorts goimports by 3-4 groups (stdlib, general, company, project dependencies)
        'staticcheck', -- linter
        'delve', -- dap, debugger

        -- lua
        'stylua', -- formatter

        -- python
        'ruff', -- formatter and linter
        -- 'mypy', -- linter, mypy is a static type checker for Python

        -- sql
        'sqlfluff', -- formatter and linter

        -- web
        --  css
        'stylelint', -- linter
        --  html
        'prettierd', -- formatter, javascript, typescript, html, css
        'htmlhint', -- linter
        --  json
        -- 'jq',
        -- sql
        'sqlfluff', -- formatter/linter: SQLFluff is a dialect-flexible and configurable SQL linter.

        -- php
        -- 'phpstan', -- linter
        -- 'php-cs-fixer', -- formatter
        'phpcs', -- linter: PHP CodeSniffer

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
    end,
  },
}
