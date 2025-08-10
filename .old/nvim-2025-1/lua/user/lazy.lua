--
-- https://github.com/folke/lazy.nvim
-- A modern plugin manager for nvim
--
-- :h lazy.nvim.txt

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- lazy options
-- https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
local opts = {
  defaults = {
    lazy = true, -- should plugins be lazy-loaded? -- default: false
  },
  spec = {
    { import = "plugins" },
  },
  install = {
    colorscheme = { vim.g.colorscheme, 'habamax' }, -- try to load one of these colorschemes when starting an installation during startup
  },
  checker = {
    enabled = false, -- automatically check for plugin updates -- default: false
  },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui -- default: true
    notify = false, -- get a notification when changes are found -- default: true
  },
  performance = {
    rtp = {
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- 'netrwPlugin',
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
}

require('lazy').setup(opts)