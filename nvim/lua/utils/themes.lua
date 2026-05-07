-- if true then return {} end
return {
	{
		"wnkz/monoglow.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
  {
    'tomasiser/vim-code-dark',
    lazy=false,
    config = function()
      vim.g.codedark_conservative=false
      vim.g.codedark_transparent=false
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy=false,
    priority = 1000,
    config = function() -- Default options:
        require('kanagawa').setup({
            compile = false,             -- enable compiling the colorscheme
            undercurl = true,            -- enable undercurls
            commentStyle = { italic = false },
            functionStyle = {},
            keywordStyle = { italic = false},
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,         -- do not set background color
            dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
            terminalColors = true,       -- define vim.g.terminal_color_{0,17}
            colors = {                   -- add/modify theme and palette colors
              palette = {},
              theme = {
                wave = {},
                lotus = {},
                dragon = {},
                all = {
                  ui = {
                    bg_gutter = "none"
                  }
                } 
              },
            },
            overrides = function(colors) -- add/modify highlights
                return {}
            end,
            theme = "wave",              -- Load "wave" theme
            background = {               -- map the value of 'background' option to a theme
                dark = "wave",           -- try "dragon" !
                light = "lotus"
            },
        })

    end,
  },
  {
    'Mofiqul/vscode.nvim',
    config = function()
      local c = require('vscode.colors').get_colors()
      require('vscode').setup({
          -- Alternatively set style in setup
          -- style = 'light'

          -- Enable transparent background
          transparent = false,

          -- Enable italic comment
          italic_comments = true,

          -- Enable italic inlay type hints
          italic_inlayhints = true,

          -- Underline `@markup.link.*` variants
          underline_links = true,

          -- Disable nvim-tree background color
          disable_nvimtree_bg = true,

          -- Apply theme colors to terminal
          -- Override colors (see ./lua/vscode/colors.lua)
          color_overrides = {
              vscLineNumber = '#FFFFFF',
          },

          -- Override highlight groups (see ./lua/vscode/theme.lua)
          group_overrides = {
              -- this supports the same val table as vim.api.nvim_set_hl
              -- use colors from this colorscheme by requiring vscode.colors!
              Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
          }
      })
    end,
  },
}


