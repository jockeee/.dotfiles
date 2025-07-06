--
-- CopilotC-Nvim/CopilotChat.nvim

-- Chat with Github Copilot in nvim

-- Default configuration
--    https://github.com/CopilotC-Nvim/CopilotChat.nvim#default-configuration
--
-- Commands
--    :CopilotChat [input]      Open chat window with optional input
--    :CopilotChatOpen          Open chat window
--    :CopilotChatClose         Close chat window
--    :CopilotChatToggle        Toggle chat window
--    :CopilotChatStop          Stop current copilot output
--    :CopilotChatReset         Reset chat window
--    :CopilotChatSave [name]   Save chat history to file
--    :CopilotChatLoad [name]   Load chat history from file
--    :CopilotChatDebugInfo     Show debug information
--    :CopilotChatModels        View and select available models. This is reset when a new instance is made. Please set your model in init.lua for persistence.
--    :CopilotChatAgents        View and select available agents. This is reset when a new instance is made. Please set your agent in init.lua for persistence.
--    :CopilotChat<PromptName>  Ask a question with a specific prompt.
--                              For example, :CopilotChatExplain will ask a question with the Explain prompt. See Prompts for more information.
--
-- Chat Mappings
--    <Tab>       Trigger completion menu for special tokens or accept current completion (see help)
--    q/<C-c>     Close the chat window
--    <C-l>       Reset and clear the chat window
--    <CR>/<C-s>  Submit the current prompt
--    gr          Toggle sticky prompt for the line under cursor
--    <C-y>       Accept nearest diff (works best with COPILOT_GENERATE prompt)
--    gj          Jump to section of nearest diff. If in different buffer, jumps there; creates buffer if needed (works best with COPILOT_GENERATE prompt)
--    gq          Add all diffs from chat to quickfix list
--    gy          Yank nearest diff to register (defaults to ")
--    gd          Show diff between source and nearest diff
--    gi          Show info about current chat (model, agent, system prompt)
--    gc          Show current chat context
--    gh          Show help message
--
-- Prompts
--    You can ask Copilot to do various tasks with prompts.
--    You can reference prompts with
--        /PromptName in chat or
--        :CopilotChat<PromptName>
--
--    Default prompts
--        Explain   Write an explanation for the selected code as paragraphs of text
--        Review    Review the selected code
--        Fix       There is a problem in this code. Rewrite the code to show it with the bug fixed
--        Optimize  Optimize the selected code to improve performance and readability
--        Docs      Please add documentation comments to the selected code
--        Tests     Please generate tests for my code
--        Commit    Write commit message for the change with commitizen convention
--
-- System Prompts
--    System prompts specify the behavior of the AI model.
--    You can reference system prompts with
--        /PROMPT_NAME in chat
--
--    Default system prompts
--        COPILOT_INSTRUCTIONS  Base Github Copilot instructions
--        COPILOT_EXPLAIN       On top of the base instructions adds coding tutor behavior
--        COPILOT_REVIEW        On top of the base instructions adds code review behavior with instructions on how to generate diagnostics
--        COPILOT_GENERATE      On top of the base instructions adds code generation behavior, with predefined formatting and generation rules
--
-- Models
--    You can list available models with :CopilotChatModels command.
--    Model determines the AI model used for the chat.
--    You can set the model in the prompt by using $ followed by the model name or default model via config using model key.
--
--    Default models
--        gpt-4o (default)
--        claude-3.5-sonnet
--        o1-preview
--        o1-mini
--
-- Agents
--    :CopilotChatAgents
--
--    Agents are used to determine the AI agent used for the chat.
--    You can set the agent in the prompt by using @ followed by the agent name or default agent via config using agent key.
--    Default "noop" agent is copilot.
--
--    Information about extension agents
--      https://docs.github.com/en/copilot/using-github-copilot/using-extensions-to-integrate-external-tools-with-copilot-chat
--    More agents
--      https://github.com/marketplace?type=apps&copilot_app=true

---@type LazySpec
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  -- event = 'VimEnter',
  -- event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    { '<leader>qq', '<cmd>CopilotChat<CR>', desc = 'Chat', mode = { 'n', 'v' } },
    { '<leader>qa', '<cmd>CopilotChatAgents<CR>', desc = 'Agents', mode = { 'n', 'v' } },
    { '<leader>qm', '<cmd>CopilotChatModels<CR>', desc = 'Models', mode = { 'n', 'v' } },
    { '<leader>ql', '<cmd>CopilotChatReset<CR>', desc = 'Reset chat', mode = { 'n', 'v' } }, -- default: C-l
    { '<leader>qs', '<cmd>CopilotChatStop<CR>', desc = 'Stop output', mode = { 'n', 'v' } },
    { '<leader>qc', '<cmd>CopilotChatCommit<CR>', desc = 'Prompt: Commit Message', mode = { 'n', 'v' } },
    { '<leader>qd', '<cmd>CopilotChatDocs<CR>', desc = 'Prompt: Add Docs', mode = { 'n', 'v' } },
    { '<leader>qe', '<cmd>CopilotChatExplain<CR>', desc = 'Prompt: Explain', mode = { 'n', 'v' } },
    { '<leader>qf', '<cmd>CopilotChatFix<CR>', desc = 'Prompt: Fix', mode = { 'n', 'v' } },
    { '<leader>qo', '<cmd>CopilotChatOptimize<CR>', desc = 'Prompt: Optimize', mode = { 'n', 'v' } },
    { '<leader>qr', '<cmd>CopilotChatReview<CR>', desc = 'Prompt: Review', mode = { 'n', 'v' } },
    { '<leader>qt', '<cmd>CopilotChatTests<CR>', desc = 'Prompt: Generate Tests', mode = { 'n', 'v' } },
  },
  dependencies = {
    require 'plugin.render-markdown',
    'zbirenbaum/copilot.lua', -- github/copilot.vim or zbirenbaum/copilot.lua
    'nvim-lua/plenary.nvim', -- for curl, log and async functions
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  opts = {
    -- model = 'claude-3.5-sonnet', -- default: gpt-4o
    highlight_headers = false, -- Highlight headers in chat, disable if using markdown renderers (like render-markdown.nvim)
    mappings = {
      reset = {
        normal = '', -- d: <C-l>, empty = disabled
        insert = '', -- d: <C-l>, empty = disabled
      },
    },
  },
  config = function(_, opts)
    local cc = require 'CopilotChat'
    cc.setup(opts)

    -- Commands
    --    :CopilotChat [input]      Open chat window with optional input
    --    :CopilotChatOpen          Open chat window
    --    :CopilotChatClose         Close chat window
    --    :CopilotChatToggle        Toggle chat window
    --    :CopilotChatStop          Stop current copilot output
    --    :CopilotChatReset         Reset chat window
    --    :CopilotChatSave [name]   Save chat history to file
    --    :CopilotChatLoad [name]   Load chat history from file
    --    :CopilotChatDebugInfo     Show debug information
    --    :CopilotChatModels        View and select available models. This is reset when a new instance is made. Please set your model in init.lua for persistence.
    --    :CopilotChatAgents        View and select available agents. This is reset when a new instance is made. Please set your agent in init.lua for persistence.
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qq', '<cmd>CopilotChat<CR>', { desc = 'Chat' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qa', '<cmd>CopilotChatAgents<CR>', { desc = 'Agents' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qm', '<cmd>CopilotChatModels<CR>', { desc = 'Models' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>ql', '<cmd>CopilotChatReset<CR>', { desc = 'Reset chat' }) -- default: C-l
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qs', '<cmd>CopilotChatStop<CR>', { desc = 'Stop output' })

    -- Prompts
    --    :CopilotChat<PromptName>  Ask a question with a specific prompt.
    --                              For example, :CopilotChatExplain will ask a question with the Explain prompt. See Prompts for more information.
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qc', '<cmd>CopilotChatCommit<CR>', { desc = 'Prompt: Commit Message' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qd', '<cmd>CopilotChatDocs<CR>', { desc = 'Prompt: Add Docs' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qe', '<cmd>CopilotChatExplain<CR>', { desc = 'Prompt: Explain' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qf', '<cmd>CopilotChatFix<CR>', { desc = 'Prompt: Fix' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qo', '<cmd>CopilotChatOptimize<CR>', { desc = 'Prompt: Optimize' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qr', '<cmd>CopilotChatReview<CR>', { desc = 'Prompt: Review' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>qt', '<cmd>CopilotChatTests<CR>', { desc = 'Prompt: Generate Tests' })
  end,
}
