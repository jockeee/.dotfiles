--
-- https://github.com/nvim-tree/nvim-tree.lua
-- File explorer tree
--
-- Show all the highlights that nvim-tree uses.
--    :NvimTreeHiTest
--
-- Configuration
--    :h nvim-tree-setup
--    :h nvim-tree-opts
--
-- Keybindings
--    g?   help
--    E    Exand all
--    W    Collapse all
--    C    filter: changed files
--    f    filter: search term, clear with F
--
-- Icons
--    ✗  unstaged
--    ✓  staged
--      unmerged
--    ➜  renamed
--    ★  untracked
--      deleted
--    ◌  ignored

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  keys = { { '\\', '<cmd>NvimTreeToggle<cr>' } },
  config = function()
    require('nvim-tree').setup {
      disable_netrw = true,
      hijack_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,

      sort = {
        sorter = 'case_sensitive', -- default: 'name'
      },
      view = {
        width = 40,
        adaptive_size = true,
      },
      renderer = {
        group_empty = true, -- group folders that only contain a single folder into one
        icons = {
          git_placement = 'after',
        },
      },
      update_focused_file = {
        enable = true,
      },
      git = {
        show_on_open_dirs = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
      },
      filters = {
        dotfiles = false, -- filter out dotfiles
        custom = {
          '^.git$',
        },
      },
    }

    -- If not using update_focused_file
    -- vim.keymap.set({ 'n', 'v' }, '<leader>g', '<cmd>NvimTreeFindFile<cr>', { desc = 'NvimTree: Goto File' })

    --
    -- Recipes
    --

    -- Find and focus directory with telescope
    --    https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#find-and-focus-directory-with-telescope

    -- Make :bd and :q behave as usual when tree is visible
    --    https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#make-q-and-bd-work-as-if-tree-was-not-visible
    vim.api.nvim_create_autocmd({ 'BufEnter', 'QuitPre' }, {
      nested = false,
      callback = function(e)
        local tree = require('nvim-tree.api').tree

        -- Nothing to do if tree is not opened
        if not tree.is_visible() then return end

        -- How many focusable windows do we have? (excluding e.g. incline status window)
        local winCount = 0
        for _, winId in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_config(winId).focusable then winCount = winCount + 1 end
        end

        -- We want to quit and only one window besides tree is left
        if e.event == 'QuitPre' and winCount == 2 then vim.api.nvim_cmd({ cmd = 'qall' }, {}) end

        -- :bd was probably issued an only tree window is left
        -- Behave as if tree was closed (see `:h :bd`)
        if e.event == 'BufEnter' and winCount == 1 then
          -- Required to avoid "Vim:E444: Cannot close last window"
          vim.defer_fn(function()
            -- close nvim-tree: will go to the last buffer used before closing
            tree.toggle { find_file = true, focus = true }
            -- re-open nivm-tree
            tree.toggle { find_file = true, focus = false }
          end, 10)
        end
      end,
    })
  end,
}
