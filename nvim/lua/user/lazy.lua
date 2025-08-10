--
-- lua/user/lazy.lua

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
---@type vim.Option
vim.opt.rtp:prepend(lazypath)

local opts = {
  defaults = {
    lazy = false,
  },
  spec = {
    { import = 'plugins' },
  },
  install = {
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { 'nordic', 'habamax' },
  },
  checker = {
    enabled = false, -- automatically check for plugin updates -- default: false
  },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui -- default: true
    notify = false, -- get a notification when changes are found -- default: true
  },
  performance = {
    cache = {
      enabled = true, -- d: true
    },
    reset_packpath = true, -- d: true, reset the package path to improve startup time
    rtp = {
      reset = true, -- d: true, reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}

require('lazy').setup(opts)
