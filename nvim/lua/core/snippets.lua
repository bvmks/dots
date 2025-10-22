-- Custom code snippets for different purposes

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
local icons = require('utils.icons').diagnostics
-- Appearance of diagnostics
vim.diagnostic.config {
  severity_sort = true,
  virtual_text = {
    prefix = '∎',
    -- Add a custom format function to show error codes
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },
  underline = false,
  update_in_insert = true,
  float = {
    source = true, -- Or "if_many"
  },
  signs = {
    text = {
      [vim.diagnostic.severity.WARN] =  icons.Warn,
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.INFO] =  icons.Info,
      [vim.diagnostic.severity.HINT] =  icons.Hint,
    },
  },
  -- Make diagnostic background transparent
  on_ready = function()
    vim.cmd 'highlight DiagnosticVirtualText guibg=NONE'
  end,
}

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('wrap_spell', { clear = true }),
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set kitty terminal padding to 0 when in nvim
vim.cmd [[
  augroup kitty_mp
  autocmd!
  au VimLeave * :silent !kitty @ set-spacing padding=default margin=default
  au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0 0 0 0
  augroup END
]]
