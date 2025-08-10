--
-- mrjones2014/smart-splits.nvim

-- Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits.
-- Supports tmux, Wezterm, and Kitty.

---@type LazySpec
return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  opts = {
    at_edge = 'stop', -- tmux: use default, wezterm workspaces: use 'stop'
    disable_multiplexer_nav_when_zoomed = false, -- default: true
  },
  config = function(_, opts)
    local ss = require 'smart-splits'
    ss.setup(opts)

    -- resizing splits
    -- these keymaps will also accept a range,
    -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
    -- Resize windows using <alt> + arrow keys
    vim.keymap.set('n', '<M-up>', ss.resize_up, { desc = 'smart-splits: Resize Up' })
    vim.keymap.set('n', '<M-down>', ss.resize_down, { desc = 'smart-splits: Resize Down' })
    vim.keymap.set('n', '<M-left>', ss.resize_left, { desc = 'smart-splits: Resize Left' })
    vim.keymap.set('n', '<M-right>', ss.resize_right, { desc = 'smart-splits: Resize Right' })
    -- moving between splits
    vim.keymap.set('n', '<C-h>', ss.move_cursor_left, { desc = 'smart-splits: Move Left' })
    vim.keymap.set('n', '<C-j>', ss.move_cursor_down, { desc = 'smart-splits: Move Down' })
    vim.keymap.set('n', '<C-k>', ss.move_cursor_up, { desc = 'smart-splits: Move Up' })
    vim.keymap.set('n', '<C-l>', ss.move_cursor_right, { desc = 'smart-splits: Move Right' })
    vim.keymap.set('n', '<C-\\>', ss.move_cursor_previous, { desc = 'smart-splits: Move Previous' })
    -- swapping buffers between windows
    vim.keymap.set('n', '<C-w>h', ss.swap_buf_left, { desc = 'smart-splits: Swap Left' })
    vim.keymap.set('n', '<C-w>j', ss.swap_buf_down, { desc = 'smart-splits: Swap Down' })
    vim.keymap.set('n', '<C-w>k', ss.swap_buf_up, { desc = 'smart-splits: Swap Up' })
    vim.keymap.set('n', '<C-w>l', ss.swap_buf_right, { desc = 'smart-splits: Swap Right' })
  end,
}
