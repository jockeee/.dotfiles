--
-- plugin/local.lua

---@type LazySpec
return {
  {
    dir = vim.fn.stdpath 'config' .. '/local/section-header.nvim',
    lazy = false,
    opts = {
      width = 0,
      -- fill_char = '-',
      -- marker_chars = { '-', '=' },
      -- marker_len = 3,
      -- debug = false,
    },
    config = function(_, opts)
      require('section_header').setup(opts)
      vim.keymap.set('n', '<leader>=', '<cmd>FixSectionHeader<cr>', { silent = true })
    end,
  },
}
