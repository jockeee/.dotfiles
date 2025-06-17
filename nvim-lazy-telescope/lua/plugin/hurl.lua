--
-- https://github.com/jellydn/hurl.nvim
-- Run and test HTTP requests
--
-- Hurl.nvim is a Neovim plugin designed to run HTTP requests directly from .hurl files.
-- Elevate your API development workflow by executing and viewing responses without leaving your editor.
--
-- https://hurl.dev
-- https://github.com/Orange-OpenSource/hurl
--
-- Powered by curl
-- Hurl is a lightweight binary written in Rust.
-- Under the hood, Hurl HTTP engine is powered by libcurl, one of the most powerful and reliable file transfer libraries.
-- With its text file format, Hurl adds syntactic sugar to run and test HTTP requests, but it's still the curl that we love: fast, efficient and HTTP/3 ready.
--
-- Configuration
-- https://github.com/jellydn/hurl.nvim#configuration

return {
  'jellydn/hurl.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Optional, for markdown rendering with render-markdown.nvim
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown' },
      },
      ft = { 'markdown' },
    },
  },
  ft = 'hurl',
  keys = {
    -- Run API request
    { '<leader>R', '<cmd>HurlRunner<CR>', desc = 'Hurl: Run All Requests, in current file' },
    { '<leader>r', '<cmd>HurlRunnerAt<CR>', desc = 'Hurl: Run Request, current entry' },
    { '<leader>ve', '<cmd>HurlRunnerToEntry<CR>', desc = 'Run Requests, to current entry, from file beginning' },
    { '<leader>vE', '<cmd>HurlRunnerToEnd<CR>', desc = 'Run Requests, from current entry, to file ending' },
    { '<leader>vm', '<cmd>HurlToggleMode<CR>', desc = 'Toggle Mode, split/popup' },
    { '<leader>vv', '<cmd>HurlVerbose<CR>', desc = 'Run Requests, verbose mode' },
    { '<leader>vV', '<cmd>HurlVeryVerbose<CR>', desc = 'Run Requests, very verbose mode' },

    -- Run Hurl request in visual mode
    { '<leader>r', ':HurlRunner<CR>', desc = 'Hurl: Run Requests, selected', mode = 'v' },
  },
  opts = {
    debug = false, -- Show debugging info
    show_notification = false, -- Show notification on run
    mode = 'split', -- Show response in popup or split
    -- auto_close = true, -- default: true, which "breaks" floaterminal if you trigger it from this "mounted" split
    -- split_position = 'right', -- default: right
    -- split_size = '50%', -- default: 50%

    env_file = { '.env.hurl' },

    -- Default formatter
    formatters = {
      json = { 'jq' },
      html = {
        'prettier',
        '--parser',
        'html',
      },
      xml = {
        'xmlformatter',
      },
    },
    -- Default mappings for the response popup or split views
    mappings = {
      close = 'q', -- Close the response popup or split view
      next_panel = '<C-n>', -- Move to the next response popup window
      prev_panel = '<C-p>', -- Move to the previous response popup window
    },
  },
}
