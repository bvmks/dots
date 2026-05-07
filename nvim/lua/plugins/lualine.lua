-- Set lualine as statusline
return {
  'nvim-lualine/lualine.nvim',
      config = function()
    -- Eviline config for lualine
    -- Author: shadmansaleh
    -- Credit: glepnir
    local lualine = require('lualine')

    -- Color table for highlights
    -- stylua: ignore
    local icons = require 'utils.icons'
    local p = require 'utils.colors'
    local colors = {
      bg       = p.bg,
      bg_acent = p.bg_acent,
      fg       = '#bbc2cf',
      yellow   = '#ECBE7B',
      cyan     = '#008080',
      darkblue = '#081633',
      green    = '#98be65',
      orange   = '#FF8800',
      violet   = '#a9a1e1',
      magenta  = '#c678dd',
      blue     = '#51afef',
      red      = '#ec5f67',
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        disabled_filetypes = {'undotree', 'alpha', 'neo-tree', 'Avante' },
        component_separators = '',
        section_separators = '',
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg_acent } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- ins_left {
    --   function()
    --     return ' '
    --   end,
    --   color = { fg = colors.blue }, -- Sets highlighting of component
    --   padding = { left = 0, right = 1 }, -- We don't need space before this
    -- }

    
    ins_left {
      -- mode component
      function()
        return " "
      end,
      color = function()
        local mode_color = {
          n = p.acent,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = p.acent,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = p.acent,
          ce = p.acent,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = p.acent,
          t = p.acent,
        }
        return { bg = mode_color[vim.fn.mode()] }
      end,
      padding = { left = 0, right = 0 },
    }

    ins_left {
      -- mode component
      function()
        local modes = icons.mode
        local mode_icon = {
          n = modes.n,
          i = modes.i,
          v = modes.v,
          [''] = modes.v,
          V = modes.v,
          c = modes.c,
          no = modes.n,
          s = modes.s,
          S = modes.s,
          [''] = modes.s,
          ic = modes.u,
          R = modes.r,
          Rv = modes.r,
          cv = modes.c,
          ce = modes.c,
          r = modes.r,
          rm = modes.r,
          ['r?'] = modes.r,
          ['!'] = modes.u,
          t = modes.u,
        }
        return mode_icon[vim.fn.mode()]
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = p.acent,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = p.acent,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = p.acent,
          ce = p.acent,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = p.acent,
          t = p.acent,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { left = 1, right = 1 },
    }


    ins_left {
      'filename',
      color = { fg = p.a_white , gui = 'bold' },
      symbols = {
        modified = '',
        readonly = '',
        unnamed = '[no name]',
        newfile = '[new]',
      },
      fmt = function(str)
        if vim.bo.modified then
          return str .. "[+]"
        else if vim.bo.readonly then
              return str .. "[-]"
            else
              return str .. "    "
            end
        end
      end
    }

    ins_left {
      -- filesize component
      'filesize',
      cond = conditions.buffer_not_empty,
    }

    ins_left { 'location' }

    ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

    

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warn , info = icons.diagnostics.Info},
      diagnostics_color = {
        error = { fg = p.d_Error },
        warn = { fg = p.d_Warn },
        info = { fg = p.d_Info },
      },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    -- ins_left {
    --   function()
    --     return '%='
    --   end,
    -- }

    ins_right {
      -- Lsp server name .
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = '◇',
      color = { fg = p.a_white, gui = 'bold' },
    }

    -- Add components to right sections
    ins_right {
      'o:encoding', -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg =  p.a_white, gui = 'bold' },
    }

    ins_right {
      'fileformat',
      fmt = string.upper,
      icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
      color = { fg =  p.a_white, gui = 'bold' },
    }

    ins_right {
      'branch',
      icon = '',
      color = { fg = colors.violet, gui = 'bold' },
    }

    ins_right {
      'diff',
      -- Is it me or the symbol for modified us really weird
      symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }
    --
    -- ins_right {
    --   function()
    --     return '▊'
    --   end,
    --   color = { fg = colors.blue },
    --   padding = { left = 1 },
    -- }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
