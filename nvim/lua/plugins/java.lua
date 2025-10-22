return {
  'mfussenegger/nvim-jdtls',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = function()
        local jdtls = require 'jdtls'

        --  detects root
        local root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew' }
        if root_dir == '' then
          return
        end

        local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local java_home = '/usr/lib/jvm/java-21-openjdk'

        local bundles = {
          "/usr/share/java/junit.jar",
          "/usr/share/java/hamcrest-core.jar",
        }

        local config = {
          cmd = {
            java_home .. '/bin/java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xms1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',
            '-jar',
            vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
            '-configuration',
            vim.fn.stdpath 'data' .. '/mason/packages/jdtls/config_linux',
            '-data',
            workspace_dir,
          },
          root_dir = root_dir,
          workspace_folder = workspace_dir,
          capabilities = capabilities,

          settings = {
            java = {
              signatureHelp = { enabled = true },
              contentProvider = { preferred = 'fernflower' },
              completion = {
                favoriteStaticMembers = {
                  'org.junit.Assert.*',
                  'org.junit.Assume.*',
                  'org.junit.jupiter.api.Assertions.*',
                  'org.junit.jupiter.api.Assumptions.*',
                  'org.junit.jupiter.api.DynamicContainer.*',
                  'org.junit.jupiter.api.DynamicTest.*',
                },
              },
            },
          },
          init_options = {
            bundles = bundles,
          },
        }

        jdtls.start_or_attach(config)

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = 'Java: ' .. desc })
        end

        map('n', '<leader>oi', jdtls.organize_imports, 'Organize Imports')
        map('n', '<leader>ev', jdtls.extract_variable, 'Extract Variable')
        map('n', '<leader>ec', jdtls.extract_constant, 'Extract Constant')
        map('v', '<leader>em', function()
          jdtls.extract_method(true)
        end, 'Extract Method')
        map('n', '<leader>tc', jdtls.test_class, 'Run Test Class')
        map('n', '<leader>tm', jdtls.test_nearest_method, 'Run Nearest Test')
      end,
    })
  end,
}
