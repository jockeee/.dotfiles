--
-- folke/lazydev.nvim

-- :LazyDev [debug]
--    Show a notification with the lazydev settings for the current buffer.
-- :LazyDev lsp
--    Show a notification with the settings for any attached LSP servers.
--    Not limited to LuaLS.

vim.pack.add {
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/DrKJeff16/wezterm-types',
}

require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    -- Load wezterm types when the `wezterm` module is required
    { path = 'wezterm-types', mods = { 'wezterm' } },
  },
}
