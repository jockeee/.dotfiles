local sh = require 'section_header'

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.api.nvim_buf_create_user_command(0, 'FixSectionHeader', function(opts)
      sh.fix_current_line {
        force = opts.bang,
      }
    end, {
      bang = true,
    })

    vim.api.nvim_buf_create_user_command(0, 'FixAllSectionHeaders', function(opts)
      sh.fix_all {
        force = opts.bang,
      }
    end, {
      bang = true,
    })
  end,
})
