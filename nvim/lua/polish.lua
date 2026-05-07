local setcol = vim.api.nvim_set_hl
local p = require 'utils.colors'

vim.cmd 'colorscheme vscode'
vim.cmd 'hi clear NeoTreeDimText'

-- Treesitter / Syntax
setcol(0, 'SpecialChar', { fg = '#fa6952', ctermfg = 236 })
setcol(0, '@comment', { fg = '#909090', ctermfg = 236 })
setcol(0, 'Comment', {link = '@comment',})
setcol(0, '@property', { fg = '#cc5e5e', ctermfg = 167 })
setcol(0, '@keyword.import.c', { fg = '#505050', ctermfg = 240, bold = false })

-- Alpha
setcol(0, 'AlphaHeader', { fg = p.white, ctermfg = 15 })
setcol(0, 'AlphaMenu', { fg = p.a_white, ctermfg = 255 })
setcol(0, 'AlphaButtons', { fg = p.acent, ctermfg = 202 })
setcol(0, 'AlphaFooter', { fg = p.gray, ctermfg = 244 })

-- WhichKey
setcol(0, 'WhichKey', { fg = p.acent, ctermfg = 202 })
setcol(0, 'WhichKeyNormal', { bg = p.black, fg = p.a_white, ctermbg = 0, ctermfg = 255 })

-- Search / Normal
setcol(0, 'Search', { bg = '#630000', ctermbg = 52 })
setcol(0, 'Normal', { fg = p.light_gray, ctermfg = 248 })

-- NeoTree
setcol(0, 'NeoTreeDirectoryIcon', { fg = p.acent, ctermfg = 202 })
setcol(0, 'NeoTreeDirectoryName', { fg = p.acent, ctermfg = 202 })
setcol(0, 'NeoTreeModified', { fg = '#af0000', ctermfg = 124 })
setcol(0, 'NeoTreeEndOfBuffer', { fg = p.black, ctermfg = 0 })
setcol(0, 'NeoTreeIndentMarker', { fg = p.dark_gray, ctermfg = 236 })
setcol(0, 'NeoTreeFileName', { fg = p.normal, ctermfg = 252 })
setcol(0, 'NeoTreeRootName', { fg = p.a_white, ctermfg = 255 })
setcol(0, 'NeoTreeFloatNormal', { fg = p.normal, bg = p.black, ctermfg = 252, ctermbg = 0 })
setcol(0, 'NeoTreeFloatTitle', { fg = p.a_white, bg = p.black, ctermfg = 255, ctermbg = 0 })
setcol(0, 'NeoTreeFloatBorder', { fg = p.dark_gray, bg = p.black, ctermfg = 236, ctermbg = 0 })

-- Windows / StatusLine
setcol(0, 'WinSeparator', { fg = p.gray_14, ctermfg = 240 })
setcol(0, 'StatusLine', { fg = p.normal, bg = p.bg_acent, ctermfg = 252, ctermbg = 236 })
setcol(0, 'StatusLineNC', { fg = p.gray, bg = p.gray_14, ctermfg = 244, ctermbg = 240 })
setcol(0, 'EndOfBuffer', { fg = p.dark_gray, ctermfg = 236 })

-- Line numbers
setcol(0, 'LineNr', { fg = p.gray, bg = p.black, ctermfg = 244, ctermbg = 16 })
setcol(0, 'CursorLineNr', { bg = p.black, fg = p.acent, ctermbg = 0, ctermfg = 202 })
setcol(0, 'CursorLine', { bg = p.gray_16, ctermbg = 236 })
setcol(0, 'NeoTreeCursorLine', { link = 'CursorLine' })
setcol(0, 'SignColumn', {bg = p.black })

-- Messages
setcol(0, 'MsgArea', { fg = p.normal, bg = p.bg, ctermfg = 252, ctermbg = 0 })
setcol(0, 'WarningMsg', { fg = p.warn, ctermfg = 214 })
setcol(0, 'MsgSeparator', { fg = p.normal, bg = p.gray_14, ctermfg = 252, ctermbg = 240 })

-- Telescope
setcol(0, 'TelescopeBorder', { fg = p.dark_gray, bg = p.black, ctermfg = 236, ctermbg = 0 })
setcol(0, 'TelescopePreviewBorder', { link = 'TelescopeBorder' })
setcol(0, 'TelescopeResultsBorder', { link = 'TelescopeBorder' })
setcol(0, 'TelescopePromptBorder', { link = 'TelescopeBorder' })
setcol(0, 'TelescopeTitle', { fg = p.a_white, bg = p.black, ctermfg = 255, ctermbg = 0 })
setcol(0, 'TelescopePromptPrefix', { fg = p.acent, ctermfg = 202 })
setcol(0, 'TelescopeMatching', { bg = '#380047', ctermbg = 53 })

-- Pmenu
setcol(0, 'Pmenu', { fg = p.gray, bg = p.bg, ctermfg = 244, ctermbg = 0 })
setcol(0, 'PmenuSel', { fg = p.normal, bg = p.gray_19, ctermfg = 252, ctermbg = 237 })
setcol(0, 'PmenuSbar', { bg = p.dark_gray, ctermbg = 236 })
setcol(0, 'PmenuThumb', { bg = p.acent, ctermbg = 202 })

-- BufferLine
setcol(0, 'BufferLineSeparator', { bg = p.bg, ctermbg = 0 })
setcol(0, 'BufferLineSeparatorSelected', { bg = p.bg_acent, ctermbg = 236 })
setcol(0, 'BufferLineBuffer', { italic = true, fg = p.gray, bg = p.bg_acent, ctermfg = 244, ctermbg = 236 })
setcol(0, 'BufferLineBufferSelected', { fg = p.acent, bg = p.bg_acent, ctermfg = 202, ctermbg = 236 })
setcol(0, 'BufferLineBufferVisible', { italic = true, fg = p.gray, bg = p.bg_acent, ctermfg = 244, ctermbg = 236 })
setcol(0, 'BufferLineFill', { bg = p.bg, ctermbg = 0 })
setcol(0, 'BufferLineBackground', { fg = p.gray, bg = p.gray_14, ctermfg = 244, ctermbg = 240 })
setcol(0, 'BufferLineModified', { fg = '#af0000', bg = p.bg, ctermfg = 124, ctermbg = 0 })
setcol(0, 'BufferLineModifiedSelected', { fg = '#af0000', bg = p.bg_acent, ctermfg = 124, ctermbg = 236 })
setcol(0, 'BufferLineModifiedVisible', { fg = '#af0000', bg = p.bg_acent, ctermfg = 124, ctermbg = 236 })

-- Diagnostics
setcol(0, 'DiagnosticError', { fg = p.d_Error, ctermfg = 196 })
setcol(0, 'DiagnosticWarn', { fg = p.d_Warn, ctermfg = 214 })
setcol(0, 'DiagnosticHint', { fg = p.d_Hint, ctermfg = 81 })
setcol(0, 'DiagnosticInfo', { fg = p.d_Info, ctermfg = 117 })

setcol(0, 'DapBreakpoint', { fg = '#af0000', ctermfg = 117 })
setcol(0, 'DapBreakpointCondition', { fg = '#af00af', ctermfg = 117 })
setcol(0, 'DapBreakpointRejected', { fg = '#ffff00', ctermfg = 117 })
setcol(0, 'DapStopped', { fg = p.white, ctermfg = 117 })

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'alpha',
  callback = function()
    setcol(0, 'MsgArea', { fg = p.normal, bg = '#cc3400', ctermfg = 252, ctermbg = 202 })
    setcol(0, 'StatusLine', { fg = p.normal, bg = p.black, ctermfg = 252, ctermbg = 0 })
  end,
})

vim.api.nvim_create_autocmd('BufLeave', {
  pattern = 'alpha',
  callback = function()
    setcol(0, 'MsgArea', { fg = p.normal, bg = p.bg, ctermfg = 252, ctermbg = 0 })
    setcol(0, 'StatusLine', { fg = p.normal, bg = p.bg_acent, ctermfg = 252, ctermbg = 236 })
  end,
})

return {}
