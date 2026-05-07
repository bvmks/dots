return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',

    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      automatic_installation = true,
      ensure_installed = { 'codelldb' },
      handlers = {},
    }

    -- Define signs
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '●', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStopped', linehl = 'Visual', numhl = '' })

    -- Keymaps
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F6>', dap.stop, { desc = 'Debug: Stop' })
    vim.keymap.set('n', '<F7>', dap.clear_breakpoints, { desc = 'Debug: Clear breakpoints' })
    vim.keymap.set('n', '<F8>', dapui.toggle, { desc = 'Debug: Toggle UI' })

    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })

    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- UI
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Adapter
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      }
    }

    -- Helper function: ask executable + args every time
    local function ask_prog_args()
      local exe = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      local args_str = vim.fn.input('Program arguments: ')
      local args = vim.split(args_str, "%s+", { trimempty = true })
      return exe, args
    end

    -- Configurations for C, C++ and ASM
    local languages = { 'cpp', 'c', 'asm' }
    for _, lang in ipairs(languages) do
      dap.configurations[lang] = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          cwd = '${workspaceFolder}',
          stopOnEntry = false,

          program = function()
            local exe, args = ask_prog_args()
            vim.g._dap_last_exe = exe
            vim.g._dap_last_args = args
            return exe
          end,

          args = function()
            return vim.g._dap_last_args or {}
          end,
        },
      }
    end
  end,
}
