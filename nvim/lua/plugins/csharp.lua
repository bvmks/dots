return {
  'neovim/nvim-lspconfig',
  dependencies = { 'hrsh7th/cmp-nvim-lsp' },
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.csharp_lsp.setup{
      cmd = { vim.fn.expand("~/.dotnet/tools/csharp-ls") },
      filetypes = { "cs" },
      root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj"),
      capabilities = capabilities,
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local buf = ev.buf
        local function map(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
        end
        map('gd', vim.lsp.buf.definition, 'Goto Definition')
        map('K', vim.lsp.buf.hover, 'Hover')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
      end
    })
  end,
}
