local bind = vim.keymap.set

bind({ 'i', 'v' }, '<A-i>', '<Esc>')

-- bind('i', '<C-h>', '<Left>')
-- bind('i', '<C-j>', '<Down>')
-- bind('i', '<C-k>', '<Up>')
-- bind('i', '<C-l>', '<Right>')

vim.api.nvim_set_keymap(
  'i',
  '<A-Space>',
  string.rep(' ', vim.opt.shiftwidth:get()),
  { noremap = true, silent = true, expr = false }
)


bind('n', '<A-0>', '^')
-- bind('n', '-', '$')
bind('n', 'J', 'mzJ`z')
bind('n', 'n', 'nzzzv')
bind('n', 'N', 'Nzzzv')

bind('v', 'J', ":m '>+1<CR>gv=gv")
bind('v', 'K', ":m '<-2<CR>gv=gv")

bind({ 'n', 'v' }, 'x', '"_x')
bind('n', 'dx', '"_dd')

bind('n', '<C-d>', '<C-d>zz')
bind('n', '<C-u>', '<C-u>zz')

bind('n', 'Q', '<nop>')
bind({ 'n', 'x' }, '<Space>', '<Nop>', { noremap = false, silent = true })
bind('n', '<Esc>', ':noh<CR>')

bind('n', '<Leader>q', '<Cmd>q<CR>')
bind('n', '<Leader>w', '<Cmd>w<CR>')
bind('n', '<C-q>', '<Cmd>q<CR>')
bind('n', '<C-s>', '<Cmd>w<CR>')

-- bind('n', '<Leader>sn', '<Cmd>noautocmd w<CR>')

bind('n', 's', 'ciw')

-- bind('x', '<Leader>p', '"_dP')
bind('x', 'p', '"_dP')
bind({ 'n', 'v' }, '<leader>y', [["+y]], { noremap = false, silent = true })
bind('n', '<leader>Y', [["+Y]], { noremap = false, silent = true })
bind({ 'n', 'v' }, '<leader>p', [["+p]], { noremap = false, silent = true })
bind({ 'n', 'v' }, '<leader>d', [["+d]], { noremap = false, silent = true })
bind({ 'n', 'v' }, '<leader>D', [["+D]], { noremap = false, silent = true })

bind('v', '<', '<gv')
bind('v', '>', '>gv')

bind('n', '=ap', "ma=ap'a")



-- bind('n', '<Down>', ':resize -2<CR>')
-- bind('n', '<Up>', ':resize +2<CR>')
-- bind('n', '<Right>', ':vertical resize -2<CR>')
-- bind('n', '<Left>', ':vertical resize +2<CR>')

bind('n', '<A-e>', '<Cmd>Neotree toggle<CR>')
bind('n', '<Leader>o', '<Cmd>Neotree focus<CR>')

-- bind('n', '<F5>', '<Cmd>set list!<CR>')

bind('n', '<leader>]', '<cmd>set list!<CR>')

bind('n', '<leader>tw', '<cmd>set wrap!<CR>')

bind('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
bind('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

bind('n', '<A-u>', '<Cmd>redo<CR>')

bind('n', '<C-h>', '<C-w>h')
bind('n', '<C-l>', '<C-w>l')
bind('n', '<C-j>', '<C-w>j')
bind('n', '<C-k>', '<C-w>k')

bind('n', '_', '-')

bind('v', '<Tab>', '>gv')
bind('v', '<S-Tab>', '<gv')

bind('t', '<Esc><Esc>', '<C-\\><C-n>')

bind({ 'i', 'v' }, '<Leader>j', '<Esc>')

-- bind( "n" , "<Leader>o", '<Cmd>put _<CR>')
-- bind( "n" , "<Leader>O", '<Cmd>put! _<CR>')

bind('n', '<A-j>', ':m .+1<CR>==')
bind('n', '<A-k>', ':m .-2<CR>==')

bind('v', '<A-j>', ":m '>+1<CR>gv=gv")
bind('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- bind('n', '<Tab>', ':bnext<CR>')
-- bind('n', '<S-Tab>', ':bprevious<CR>')
bind('n', '<leader>bd', ':bdelete<CR>')
bind('n', '<leader>bn', ':enew <CR>')

-- bind('n', '<leader>v', '<C-w>v', {desc = "[V]ertical split", noremap = true, silent = true })
-- bind('n', '<leader>h', '<C-w>s', {desc = "[H]orizontal split", noremap = true, silent = true })
-- bind('n', '<leader>se', '<C-w>=', {desc = "Make [S]plits [E]qual", noremap = true, silent = true })
-- bind('n', '<leader>sq', ':close<CR>' )
-- bind('n', '<leader>so', ':only<CR>' )

local diagnostics_active = true

vim.keymap.set('n', '<leader>td', function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable(true)
  else
    vim.diagnostic.enable(false)
  end
end)

-- vim.keymap.set('n', 'H', require('arrow.pCrsist').previous)
-- vim.keymap.set('n', 'L', require('arrow.persist').next)
-- vim.keymap.set('n', '<Leader>m', '<Cmd>Arrow open<CR>')

-- Diagnostic keymaps
bind('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

bind('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

bind('n', '<Leader>k', vim.diagnostic.open_float, { desc = 'Open floating [D]iagnostic message' })
bind('n', '<Leader>l', vim.diagnostic.setloclist, { desc = '[T]oggle [D]iagnostics [L]ist' })

-- Save and load session
-- bind('n', '<leader>ms', ':mksession! .session.vim<CR>')
-- bind('n', '<leader>ls', ':source .session.vim<CR>')
