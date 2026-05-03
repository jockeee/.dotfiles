--
-- yetone/avante.nvim

-- Keybinds
-- https://github.com/yetone/avante.nvim#key-bindings

-- Commands
-- https://github.com/yetone/avante.nvim#commands

-- Highlight groups
-- https://github.com/yetone/avante.nvim#highlight-groups

-- @mentions
--    @codebase      Include the entire codebase context
--    @diagnostics   Include current diagnostic issues
--    @file          Include the current file
--    @quickfix      Include the quickfix list
--    @buffers       Include all open buffers

-- Commands

-- By default, avante.nvim provides three different modes to interact with: planning, editing, and suggesting, followed with three different prompts per mode.
--    planning:         Used with require("avante").toggle() on sidebar
--    editing:          Used with require("avante").edit() on selection codeblock
--    suggesting        Used with require("avante").get_suggestion():suggest() on Tab flow.
--    cursor-planning   Used with require("avante").toggle() on Tab flow, but only when cursor planning mode is enabled.

---@type LazySpec
return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  dependencies = {
    require 'plugin.render-markdown',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    -- 'echasnovski/mini.pick', -- for file_selector provider mini.pick
    -- 'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    -- 'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    -- 'ibhagwan/fzf-lua', -- for file_selector provider fzf
    -- 'stevearc/dressing.nvim', -- for input provider dressing
    'folke/snacks.nvim', -- for input provider snacks
    -- 'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    ---@type Provider
    -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
    provider = 'copilot', -- d: claude,
    ---@alias Mode "agentic" | "legacy"
    ---@type Mode
    -- The default mode for interaction.
    -- `agentic` uses tools to automatically generate code,
    -- `legacy` uses the old planning method to generate code.
    mode = 'agentic', -- d: agentic
    hints = { enabled = false }, -- d: true
  },
  config = function(_, opts)
    local avante = require 'avante'
    avante.setup(opts)

    vim.keymap.set({ 'n', 'v' }, '<leader>as', function()
      avante.toggle()
    end, { desc = 'avante: toggle' })
  end,
}
