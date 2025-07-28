local icons = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "",
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      "mason-org/mason.nvim",
      opts = {
        ui = {
          -- border = "single",
          width = 0.9,
        },
      },
    },
    "mason-org/mason-lspconfig.nvim", -- Bridges the gap in names of LSPs and Mason package names
  },
  config = function()
    local nvim_lsp = require('lspconfig')
    -- Instaleld servers
    servers = { 'pyright', 'fortls', 'clangd', 'texlab',
                'lemminx', 'cmake', 'dockerls', 'ltex_plus', 'bashls' }
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      -- Enable completion triggered by <c-x><c-o>
      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local map = function(keys, desc, func, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end
      map('gD', "", function() vim.lsp.buf.declaration() end, n)
      map('gd', "", function() vim.lsp.buf.definition() end, n)
      map('K', "", function() vim.lsp.buf.hover() end, n)
      map('gi', "", function() vim.lsp.buf.implementation() end, n)
      map('<C-,>', "", function() vim.lsp.buf.signature_help() end, n)
      map('gr', "", function() vim.lsp.buf.references() end, n)
      map('<space>wd', "", function() vim.lsp.buf.add_workspace_folder() end, n)
      map('<space>wr', "", function() vim.lsp.buf.remove_workspace_folder() end, n)
      map('<space>wl', "", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, n)
      map('<space>D', "", function() vim.lsp.buf.type_definition() end, n)
      map('<space>rn', "", function() vim.lsp.buf.rename() end, n)
      map('<space>ca', "", function() vim.lsp.buf.code_action() end, n)
      map('<space>e', "", function() vim.diagnostic.open_float() end, n)
      map('[d', "", function() vim.diagnostic.goto_prev() end, n)
      map(']d', "", function() vim.diagnostic.goto_next() end, n)
      -- map('<space>q', "", function() vim.diagnostic.setloclist() end, n)
      -- map('<space>f', "", function() vim.lsp.buf.formatting() end, n)

    end

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()) -- completion

    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end
  end,
}
