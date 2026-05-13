--
-- saghen/blink.cmp

vim.pack.add {
  'https://github.com/saghen/blink.cmp',
  'https://github.com/saghen/blink.lib',
}

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'blink.cmp' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'blink.cmp'
      end
      ---@diagnostic disable-next-line: undefined-field
      require('blink.cmp').build():wait(60000)
    end
  end,
})

require('blink.cmp').setup {
  cmdline = {
    keymap = {
      preset = 'super-tab',
      ['<CR>'] = { 'accept_and_enter', 'fallback' },
      ['<Tab>'] = { 'show_and_insert', 'select_and_accept' },
      ['<C-y>'] = { 'accept', 'fallback' },
    },
    completion = {
      menu = { auto_show = false },
    },
  },

  completion = {
    -- By default, you may press `<C-space>` to show the documentation.
    -- Optionally, set `auto_show = true` to show the documentation after a delay.
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 300,
      window = {
        border = 'single',
        -- winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,NormalFloat:Pmenu',
      },
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
  },

  keymap = {
    preset = 'super-tab',
  },

  sources = {
    -- add lazydev to your completion providers
    -- default = { 'lazydev', 'lsp', 'path', 'snippets' },
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

  -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
  -- which automatically downloads a prebuilt binary when enabled.
  --
  -- By default, we use the Lua implementation instead, but you may enable
  -- the rust implementation via `'prefer_rust_with_warning'`
  --
  -- See :h blink-cmp-config-fuzzy for more information
  fuzzy = { implementation = 'prefer_rust_with_warning' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}
