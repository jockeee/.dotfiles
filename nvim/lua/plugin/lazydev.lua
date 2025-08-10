--
-- folke/lazydev.nvim

---@type LazySpec
return {
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  'folke/lazydev.nvim',
  lazy = false,
  ft = 'lua',
  dependencies = {
    { 'gonstoll/wezterm-types' }, -- wezterm (config) types for lua language server
  },
  opts = {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } }, -- Load luvit types when the `vim.uv` word is found
      { path = 'wezterm-types', mods = { 'wezterm' } }, -- Load wezterm types when the `wezterm` module is required
    },
  },
}
