--
-- https://github.com/nvim-tree/nvim-tree.lua
-- A file explorer tree for neovim written in lua
--
-- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
--
-- lualine integration
-- https://github.com/nvim-lualine/lualine.nvim#extensions
--    extensions = { 'nvim-tree' }

local LEFT_MARGIN = 0 -- 7
local WIDTH = 60
local HEIGHT_RATIO = 0.98 -- 0.94

return {
  'kyazdani42/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' }, -- for pretty icons, requires a nerd font
  keys = { { '\\', '<cmd>NvimTreeToggle<cr>' } },
  config = function()
    require('nvim-tree').setup {
      disable_netrw = true,
      hijack_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      renderer = {
        group_empty = true,
      },
      update_focused_file = {
        enable = true,
      },
      view = {
        -- relativenumber = true,

        -- Floating window to the left, centered vertically
        float = {
          enable = true,
          open_win_config = function()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get() - 1 -- last is lualine = 1
            local window_h = screen_h * HEIGHT_RATIO
            local window_h_int = math.floor(window_h)
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y, -- start position from top edge, 0 is the top edge
              col = LEFT_MARGIN, -- start position from left edge, 0 is the left edge
              width = WIDTH, -- window_w_int
              height = window_h_int,
            }
          end,
        },
        width = WIDTH,

        -- Floating window to the left
        -- nvim-tree-lua.txt
        --
        -- float = {
        --   enable = true,
        --   quit_on_focus_loss = true,
        --   open_win_config = {
        --     relative = 'editor',
        --     border = 'rounded',
        --     width = 30,
        --     height = 30,
        --     row = 1,
        --     col = 1,
        --   },
        -- },

        -- -- Floating window in center
        -- https://github.com/MarioCarrion/videos/blob/269956e913b76e6bb4ed790e4b5d25255cb1db4f/2023/01/nvim/lua/plugins/nvim-tree.lua
        -- float = {
        --   enable = true,
        --   open_win_config = function()
        --     local screen_w = vim.opt.columns:get()
        --     local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        --     local window_w = screen_w * WIDTH_RATIO
        --     local window_h = screen_h * HEIGHT_RATIO
        --     local window_w_int = math.floor(window_w)
        --     local window_h_int = math.floor(window_h)
        --     local center_x = (screen_w - window_w) / 2
        --     local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
        --     return {
        --       border = 'rounded',
        --       relative = 'editor',
        --       row = center_y,
        --       col = center_x,
        --       width = window_w_int,
        --       height = window_h_int,
        --     }
        --   end,
        -- },
        -- width = function()
        --   return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        -- end,
      },
    }
  end,
}
