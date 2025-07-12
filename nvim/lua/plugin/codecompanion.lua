--
-- olimorris/codecompanion.nvim

-- The default adapter in CodeCompanion is GitHub Copilot.
-- If you have copilot.vim or copilot.lua installed then expect CodeCompanion to work out of the box.

-- Copilot (copilot) - Requires a token which is created via :Copilot setup in Copilot.vim

-- Chat
--    :CodeCompanionChat Toggle
--
--    ga   Change adapter
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
--      Prompt: What does the code in #{buffer} do?
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
--        cmd_runner              The LLM will run shell commands (subject to approval)
--        create_file             The LLM will create a file in the current working directory (subject to approval)
--        file_search             The LLM can search for a file in the CWD
--        get_changed_files       The LLM can get git diffs for any changed files in the CWD
--        grep_search             The LLM can search within files in the CWD
--        insert_edit_into_file   The LLM will edit code in a Neovim buffer or on the file system (subject to approval)
--        next_edit_suggestion    The LLM can show the user where the next edit is
--        read_file               The LLM can read a specific file
--        web_search              The LLM can search the internet for information
--      Tools can also be grouped together, also accessible via @ in the chat buffer
--        `files` contains the create_file, file_search, get_changed_files, grep_search, insert_edit_into_file and read_file tools
--      Prompt: Can you use the @{grep_search} tool to find occurrences of "add_message"

---@type LazySpec
return {
  'olimorris/codecompanion.nvim',
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
    display = {
      action_palette = {
        provider = 'snacks', -- use snacks for CodeCompanionActions
        inline_prompt = { enabled = true }, -- For inline prompts
      },
      chat = {
        show_settings = false, -- d: false, Adapters can't be changed with `ga` when set to true
      },
    },

    strategies = {
      chat = {
        adapter = 'copilot', -- d: copilot
        -- model = 'claude-sonnet-4',
      },
      inline = {
        adapter = 'copilot', -- d: copilot
      },
      cmd = {
        adapter = 'copilot', -- d: copilot
        model = 'claude-sonnet-4',
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
  -- config = function(_, opts)
  --   local cc = require 'codecompanion'
  --   cc.setup(opts)
  --
  --   require('plugin.codecompanion.fidget-spinner'):init()
  -- end,
}
