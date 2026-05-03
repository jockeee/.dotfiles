--
-- harpoon/tree/harpoon2

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'UIEnter',
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

    -- M-[a-d,z-c] for file 1-6
    -- M-f used by wezterm
    for idx, char in ipairs { 'a', 's', 'd', 'z', 'x', 'c' } do
      vim.keymap.set('n', string.format('<M-%s>', char), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
