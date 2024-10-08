--
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
  'ThePrimeagen/harpoon',
  event = 'VimEnter',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    settings = {
      save_on_toggle = true, -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    },
  },
  config = function(_, opts)
    local harpoon = require 'harpoon'
    harpoon:setup(opts)

    -- M-h Harpoon List
    -- M-m Add "Mark"
    -- M-p Next
    -- M-n Previous
    vim.keymap.set('n', '<M-h>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    vim.keymap.set('n', '<M-m>', function()
      harpoon:list():add()
    end)
    vim.keymap.set('n', '<M-n>', function()
      harpoon:list():next()
    end)
    vim.keymap.set('n', '<M-p>', function()
      harpoon:list():prev()
    end)

    -- <alt>a-f for file 1-4
    for idx, char in ipairs { 'a', 's', 'd', 'f' } do
      vim.keymap.set('n', string.format('<M-%s>', char), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
