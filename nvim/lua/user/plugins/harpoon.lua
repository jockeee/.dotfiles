--
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
  'ThePrimeagen/harpoon',
  event = 'VimEnter',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- M-h Add
    -- M-l List
    -- M-n Previous
    -- M-m Next
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

    -- <alt>a-f for file 1-4
    -- <alt>z-v for file 5-8
    for key, value in ipairs { 'a', 's', 'd', 'f', 'z', 'x', 'c', 'v' } do
      vim.keymap.set('n', string.format('<M-%s>', value), function()
        harpoon:list():select(key)
      end, { desc = string.format('Harpoon: File %d', key) })
    end
  end,
}
