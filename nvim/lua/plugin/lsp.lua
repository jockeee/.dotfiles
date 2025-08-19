return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
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
        pylsp = { -- python-lsp/python-lsp-server
          settings = {
            pylsp = {
              plugins = {
                -- ruff = {
                --   enabled = true,
                --   extendSelect = { 'I' },
                -- },
                pycodestyle = {
                  enabled = true,
                  -- E501 line too long (83 > 79 characters)
                  -- ignore = { 'E501', 'W503' },
                  ignore = { 'E501' },
                },
                mypy = { enabled = true },
              },
            },
          },
        },

        -- web

        -- css
        cssls = {}, -- microsoft/vscode-css-languageservice
        css_variables = {}, -- vunguyentuan/vscode-css-variables, autocompletion and go-to-definition for project-wide CSS variables.
        tailwindcss = {
          filetypes = { 'html', 'javascript', 'php' },
        },

        -- html
        html = { -- microsoft/vscode-html-languageservice
          filetypes = { 'html', 'template', 'templ' },
        },

        -- js
        --
        -- biome
        biome = {
          -- root_dir = nil,
          -- root_markers = { '.git', 'package.json', 'biome.json', 'biome.jsonc' },
          workspace_required = false,
        },
        --
        -- ts_ls = {
        --   single_file_support = true,
        -- },
        --
        -- eslint-lsp
        --  https://github.com/Microsoft/vscode-eslint
        --  The server uses the ESLint library installed in the opened workspace folder.
        --  If the folder doesn't provide one the extension looks for a global install version.
        eslint = {},
        -- biome
        --  nvim-lspconfig default config for biome respects eslint/prettier projects.
        --  = requires `biome.json` or `biome.jsonc` in project root or biome won't attach.
        --  `cmd` use projects biome verion, fallback global install.
        -- biome = {},

        -- emmet
        --  aca/emmet-ls
        emmet_ls = {
          filetypes = { 'html', 'css', 'javascript' },
          init_options = {
            html = {
              options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ['bem.enabled'] = true,
              },
            },
          },
        },

        -- json
        jsonls = {},
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
