--
-- nvim-treesitter/nvim-treesitter

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
}

require('nvim-treesitter').install {
  'bash',
  'c',
  'css',
  'diff',
  'fish',
  'html',
  'ini',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'vim',
  'vimdoc',
  'yaml',
}

vim.treesitter.language.register('bash', 'ini')
