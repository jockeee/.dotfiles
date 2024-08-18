--
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
  'ThePrimeagen/harpoon',
  event = { 'BufReadPre', 'BufNewFile' },
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<M-h>', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: Add file' })
    vim.keymap.set('n', '<M-l>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: List' })
    vim.keymap.set('n', '<M-n>', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon: Previous' })
    vim.keymap.set('n', '<M-m>', function()
      harpoon:list():next()
    end, { desc = 'Harpoon: Next' })
    vim.keymap.set('n', '<M-a>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: File 1' })
    vim.keymap.set('n', '<M-s>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: File 2' })
    vim.keymap.set('n', '<M-d>', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon: File 3' })
    vim.keymap.set('n', '<M-f>', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon: File 4' })
  end,
}
