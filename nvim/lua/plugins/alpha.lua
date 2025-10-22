local p = require 'utils.colors'
return {
  'goolord/alpha-nvim',
  priority = 2000,
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    local header = require('utils.alpha-headers')[1]

    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl_shortcut = 'AlphaButtons'
      return b
    end

    dashboard.section.header.val = header
    dashboard.section.buttons.val = {
      button('n', '+  NEW', ':ene <BAR> startinsert <CR>'),
      button('o', '▣  OPEN FILE', ':Telescope find_files <CR>'),
      -- button("p", icons.git.repo .. " Find project", "<cmd>lua require('telescope').extensions.projects.projects()<cr>"),
      button('r', '☰ RECENT FILES', '<cmd>Telescope oldfiles<cr>'),
      -- button("t", icons.kinds.nvchad.Text .. " FIND", ":Telescope live_grep <CR>"),
      button('c', '⚙  CONFIG', '<cmd>e ~/.config/nvim/ | cd %:p:h<cr>'),
      button('l', '∴  LAZY', '<cmd>Lazy<cr>'),
      button('q', '×  QUIT', ':qa<CR>'),
    }

    local function date()
      local footer_datetime = os.date '%Y-%m-%d   %H:%M:%S'
      return footer_datetime
    end
    dashboard.section.footer.val = date()

    dashboard.section.header.opts = {
      position = 'center',
      hl = 'AlphaHeader',
    }

    dashboard.section.footer.opts = {
      position = 'center',
      hl = 'AlphaFooter',
    }

    dashboard.section.buttons.opts = {
      position = 'center',
      hl = 'AlphaMenu',
    }

    local bottom_section = {
      type = 'text',
      val = '',
      opts = { position = 'center' },
    }

    local section = {
      header = dashboard.section.header,
      buttons = dashboard.section.buttons,
      footer = dashboard.section.footer,
      bottom_section = bottom_section,
    }

    local function get_top_padding(image)
      local total_lines = #section.header.val + #section.buttons.val + #section.footer.val - 16
      local win_height = vim.api.nvim_win_get_height(0)
      return math.max(2, math.floor((win_height - total_lines) / 2))
    end

    local opts = {
      layout = {
        { type = 'padding', val = get_top_padding(header) },
        section.header,
        { type = 'padding', val = 1 },
        section.buttons,
        { type = 'padding', val = 1 },
        section.footer,
        { type = 'padding', val = 1 },
        section.bottom_section,
      },
    }
    dashboard.opts.opts.noautocmd = false

    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'AlphaReady',
        callback = function()
          require('lazy').show()
        end,
      })
    end

    alpha.setup(opts)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'alpha',
      callback = function()
        vim.opt_local.fillchars = vim.opt_local.fillchars + { eob = ' ' } -- заменяем ~ на пробел
      end,
    })

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = { 'AlphaReady' },
      callback = function()
        vim.cmd [[ set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3 ]]
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'AlphaReady',
      callback = function(ev)
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_set_hl(0, 'MsgArea', { fg = p.normal, bg = p.black })
        vim.api.nvim_set_hl(0, 'StatusLine', { fg = p.normal, bg = p.black })

        vim.api.nvim_create_autocmd('BufWinLeave', {
          buffer = ev.buf,
          once = true,
          callback = function()
            if vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_set_hl(0, 'MsgArea', { fg = p.normal, bg = p.bg })
              vim.api.nvim_set_hl(0, 'StatusLine', { fg = p.normal, bg = p.bg_acent })
            end
          end,
        })
      end,
    })
  end,
}
