--
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
-- Chat with GitHub Copilot in nvim

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    event = 'VimEnter',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      -- { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
