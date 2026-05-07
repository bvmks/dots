local set = vim.opt

-- vim.opt.clipboard ="unnamedplus"

-- vim.opt.guicursor = "
-- vim.opt.laststatus = 2
vim.opt.formatoptions:remove { 'o' }

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.g.have_nerd_font = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.optsplitright = true
vim.opt.splitbelow = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
-- vim.g.loaded_netrw = 1

-- vim.opt.mouse = "a"

vim.opt.fillchars = {
  -- eob = "⡂",
  horiz = '─',
  horizup = '┴',
  horizdown = '┬',
  vert = '│',
  vertleft = '┤',
  vertright = '├',
  verthoriz = '┼',
}

vim.opt.shortmess:append { s = true, I = true }

vim.opt.pumheight = 10

vim.opt.confirm = true

vim.opt.showtabline = 0

vim.opt.conceallevel = 0

vim.opt.cursorline = true
vim.opt.cursorcolumn = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1

vim.opt.autoindent = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.scrolloff = 8
-- vim.opt.sidescrolloff = 8

vim.opt.showmode = false
vim.opt.showcmd = true

-- vim.opt.colorcolumn = "80"

vim.opt.updatetime = 50
-- vim.opt.timeout = true
vim.opt.timeoutlen = 300
-- vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 0

vim.opt.completeopt = 'menuone,noselect'

vim.opt.signcolumn = 'yes'

vim.opt.inccommand = 'split'

vim.opt.whichwrap = 'bs<>[]hl'

vim.opt.listchars = { tab = '▸·', trail = '·', nbsp = '␣', precedes = '<', lead = '·', space = '·' }

-- vim.opt.isfname:append '@-@'

vim.opt.shortmess:append 'c' -- don't give |ins-completion-menu| messages
-- vim.opt.iskeyword:append '-' -- hyphenated words recognized by searches
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- separate vim plugins from neovim in case vim still
