--
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VimEnter',
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
    vim.keymap.set('n', '<M-h>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    vim.keymap.set('n', '<M-m>', function()
      harpoon:list():add()
    end)

    -- M-n Next -- M-n used for quicklist next
    -- M-p Previous -- M-p used for quicklist prev
    -- vim.keymap.set('n', '<M-n>', function() -- M-n used for quicklist next
    --   harpoon:list():next()
    -- end)
    -- vim.keymap.set('n', '<M-p>', function() -- M-p used for quicklist prev
    --   harpoon:list():prev()
    -- end)

    -- <alt>a-g for file 1-5
    for idx, char in ipairs { 'a', 's', 'd', 'f', 'g' } do
      vim.keymap.set('n', string.format('<M-%s>', char), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
