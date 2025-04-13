--
-- https://github.com/Saghen/blink.cmp
-- Performant, batteries-included completion plugin for Neovim
--
-- https://cmp.saghen.dev/

return {
  {
    'saghen/blink.cmp',
    lazy = false,
    version = '*',
    dependencies = {
      'saghen/blink.compat', -- optional: compatibility layer for nvim-cmp
      'rafamadriz/friendly-snippets', -- optional: provides snippets for the snippet source
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        use_nvim_cmp_as_default = false, -- default: false
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before and after the cursor
        keyword = { range = 'prefix' }, -- default: 'prefix'

        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        -- set to 'none' to disable the 'default' preset
        preset = 'none',

        -- disable a keymap from the preset
        -- ['<C-e>'] = {},

        -- show with a list of providers
        -- ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },

        -- default + super-tab
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-y>'] = { 'select_and_accept' },

        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          'snippet_forward',
          'fallback',
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-q>'] = { 'scroll_documentation_down', 'fallback' },
        -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' }, -- disabled, C-f configured for copilot

        -- default
        -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        -- ['<C-e>'] = { 'hide' },
        -- ['<C-y>'] = { 'select_and_accept' },
        --
        -- ['<C-p>'] = { 'select_prev', 'fallback' },
        -- ['<C-n>'] = { 'select_next', 'fallback' },
        --
        -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        --
        -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
        -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        -- super-tab
        -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        -- ['<C-e>'] = { 'hide', 'fallback' },
        --
        -- ['<Tab>'] = {
        --   function(cmp)
        --     if cmp.snippet_active() then
        --       return cmp.accept()
        --     else
        --       return cmp.select_and_accept()
        --     end
        --   end,
        --   'snippet_forward',
        --   'fallback'
        -- },
        -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        --
        -- ['<Up>'] = { 'select_prev', 'fallback' },
        -- ['<Down>'] = { 'select_next', 'fallback' },
        -- ['<C-p>'] = { 'select_prev', 'fallback' },
        -- ['<C-n>'] = { 'select_next', 'fallback' },
        --
        -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },

      signature = { enabled = true },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      --
      -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
      sources = {
        -- add lazydev to your completion providers
        -- default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'emoji' },
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          -- emoji = {
          --   name = 'emoji',
          --   module = 'blink.compat.source',
          --   -- overwrite kind of suggestion
          --   transform_items = function(ctx, items)
          --     local kind = require('blink.cmp.types').CompletionItemKind.Text
          --     for i = 1, #items do
          --       items[i].kind = kind
          --     end
          --     return items
          --   end,
          -- },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
