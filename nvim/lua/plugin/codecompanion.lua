--
-- olimorris/codecompanion.nvim

-- Default adapter:
--  GitHub Copilot
--  If you have copilot.vim or copilot.lua installed then expect CodeCompanion to work out of the box.
--  Copilot (copilot) - Requires a token which is created via :Copilot setup in Copilot.vim

-- Chat keymaps:
--  https://codecompanion.olimorris.dev/usage/chat-buffer/#keymaps
--  https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua#L288
--
--    ga    Change adapter
--    gta   Toggle automatic tool mode
--    gy    Yank code
--    gs    Toggle system prompt
--    gx    Clear chat buffer
--    gw    Watch buffer

-- Chat
--    :CodeCompanionChat Toggle
--
--    :CodeCompanionChat [prompt]
--      Open the chat buffer and send a prompt/question at the same time
--      :CodeCompanionChat What does the code in #{buffer} do?
--
--    Add context from your code base by using
--
--      Variables `#` contain data about the present state of Neovim
--        #buffer     shares the current buffer's code
--        #lsp        shares lsp information and code for the current buffer
--        #viewport   shares the buffers and lines that you see in the Neovim viewport
--
--      Slash commands `/` run commands to insert additional context into the chat buffer
--        /buffer     Insert open buffers
--        /fetch      Insert URL contents
--        /file       Insert a file
--        /quickfix   Insert entries from the quickfix list
--        /help       Insert content from help tags
--        /now        Insert the current date and time
--        /symbols    Insert symbols from a selected file
--        /terminal   Insert terminal output
--
--      Agents, Tools `@` allow the LLM to function as an agent and carry out actions
--        @cmd_runner              The LLM will run shell commands (subject to approval)
--        @create_file             The LLM will create a file in the current working directory (subject to approval)
--        @file_search             The LLM can search for a file in the CWD
--        @get_changed_files       The LLM can get git diffs for any changed files in the CWD
--        @grep_search             The LLM can search within files in the CWD
--        @insert_edit_into_file   The LLM will edit code in a Neovim buffer or on the file system (subject to approval)
--        @next_edit_suggestion    The LLM can show the user where the next edit is
--        @read_file               The LLM can read a specific file
--        @web_search              The LLM can search the internet for information
--
--        @files
--
--      Tool groups, also accessible via @ in the chat buffer
--        @full_stack_dev         alias for all tools
--        @files                  create_file, file_search, get_changed_files, grep_search, insert_edit_into_file and read_file tools
--
--      Prompt examples:
--        What does the code in #{buffer} do?
--        Can you use the @{grep_search} tool to find occurrences of "add_message"

---@type LazySpec
return {
  'olimorris/codecompanion.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    { '<leader>qq', mode = { 'n', 'x' }, '<cmd>CodeCompanionChat Toggle<cr>', desc = 'chat: toggle' },
    { '<leader>qn', mode = { 'n', 'x' }, '<cmd>CodeCompanionChat<cr>', desc = 'chat: new' },
    { '<leader>qa', mode = { 'n', 'x' }, '<cmd>CodeCompanionActions<cr>', desc = 'actions' },
  },
  cmd = { 'CodeCompanion', 'CodeCompanionActions', 'CodeCompanionChat', 'CodeCompanionCmd' },
  dependencies = {
    require 'plugin.render-markdown',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/mcphub.nvim', -- mcp extension
    -- 'j-hui/fidget.nvim', -- fidget status, https://github.com/olimorris/codecompanion.nvim/discussions/813
    'franco-ruggeri/codecompanion-spinner.nvim', -- virtual line status, https://github.com/olimorris/codecompanion.nvim/discussions/640
  },
  opts = {
    strategies = {
      chat = {
        adapter = 'copilot', -- d: copilot
        -- model = 'claude-sonnet-4',
        keymaps = {
          stop = {
            modes = {
              n = '<leader>qs',
            },
            index = 5,
            callback = 'keymaps.stop',
            description = 'chat: stop request',
          },
        },
      },
      inline = {
        adapter = 'copilot', -- d: copilot
        -- model = 'claude-sonnet-4',
      },
      cmd = {
        adapter = 'copilot', -- d: copilot
        -- model = 'claude-sonnet-4',
      },
    },

    display = {
      action_palette = {
        provider = 'snacks', -- use snacks for CodeCompanionActions
        inline_prompt = { enabled = true }, -- For inline prompts
      },
      chat = {
        -- window = {
        --   layout = 'horizontal', -- d: vertical, float|vertical|horizontal|buffer
        --   height = 0.4, -- d: 0.8
        -- },
        -- intro_message = '', -- d: Welcome to CodeCompanion ✨! Press ? for options
        -- show_settings = true, -- d: false, adapter can't be changed, with `ga`, when true
        -- start_in_insert_mode = true, -- d: false
      },
    },

    extensions = {
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
      spinner = {},
    },
  },
  config = function(_, opts)
    local cc = require 'codecompanion'
    cc.setup(opts)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'codecompanion',
      callback = function()
        vim.keymap.set('n', 'q', function()
          cc.toggle()
        end, { buffer = true, desc = 'chat: toggle' })
      end,
    })

    -- require('plugin.codecompanion.fidget-spinner'):init()
  end,
}
