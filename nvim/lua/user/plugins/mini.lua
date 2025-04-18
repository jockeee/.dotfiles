--
-- https://github.com/echasnovski/mini.nvim
-- Library of 40+ independent Lua modules improving overall nvim (version 0.8 and higher) experience with minimal effort

return {
  'echasnovski/mini.nvim',
  version = '*', -- * stable, false = main, for the latest features
  event = 'VimEnter',
  -- event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    -- a/i textobjects
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
    -- Better Around/Inside textobjects
    -- Extend and create a/i textobjects
    --
    -- Examples:
    --    va)  - [V]isually select [A]round [)]paren
    --    yinq - [Y]ank [I]nside [N]ext [']quote
    --    ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Icons
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-icons.md
    -- Icons, via nerd font
    -- require('mini.icons').setup()
    -- MiniIcons.mock_nvim_web_devicons()

    -- Bracketed
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
    -- Go forward/backward with square brackets
    --
    -- Examples:
    --    [B [b ]b ]B   buffer
    --    [C [c ]c ]C   comment
    --    [D [d ]d ]D   diagnostics
    --    [T [t ]t ]T   treesitter node and parents
    --
    -- require('mini.bracketed').setup()

    -- Surround
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
    --
    -- Examples:
    --    sa    add surrounding
    --    sd    delete surround
    --    sf    find surrounding, forward
    --    sF    find surrounding, backwards
    --    sh    highlight surrounding
    --    sr    replace surrounding
    -- require('mini.surround').setup {
    --   mappings = {
    --     add = '<leader>sa', -- Add surrounding in Normal and Visual modes
    --     delete = '<leader>sd', -- Delete surrounding
    --     find = '<leader>sf', -- Find surrounding (to the right)
    --     find_left = '<leader>sF', -- Find surrounding (to the left)
    --     highlight = '<leader>sh', -- Highlight surrounding
    --     replace = '<leader>sc', -- Replace surrounding "change"
    --     update_n_lines = '<leader>sn', -- Update `n_lines`
    --     suffix_last = nil, -- 'p', -- Suffix to search with "prev" method, shows up when doing <leader>sf/F
    --     suffix_next = nil, -- 'n', -- Suffix to search with "next" method, shows up when doing <leader>sf/F
    --   },
    --
    --   -- Number of lines within which surrounding is searched
    --   n_lines = 20, -- default: 20
    -- }

    -- Split/Join
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md
    --
    -- Examples:
    --    gS    toggle
    -- require('mini.splitjoin').setup()
  end,
}
