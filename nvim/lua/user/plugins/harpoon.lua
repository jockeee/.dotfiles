--
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<M-h', function()
      harpoon:list():add()
    end)
    vim.keymap.set('n', '<M-l>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    vim.keymap.set('n', '<M-n>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<M-m>', function()
      harpoon:list():next()
    end)
    vim.keymap.set('n', '<M-a>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<M-s>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<M-d>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<M-f>', function()
      harpoon:list():select(4)
    end)
  end,
}
