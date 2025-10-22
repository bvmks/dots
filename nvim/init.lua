local tryload = function(module)
  local status, result = pcall(require, module)
  if status then
    return result, status
  else
    print('Failed to load ' .. module)
    return {}, status
  end
end

tryload 'core.options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local themes = tryload 'utils.themes'

local plugins = {}

require('lazy').setup {
  spec = {
    -- plugins
    plugins,
    themes,
    -- import dirs
    { import = 'plugins' },
  },
  opts = {
    --options go here
  },
  checker = { enabled = false },
}

tryload 'core.keymaps'
tryload 'core.snippets'
tryload 'polish'
