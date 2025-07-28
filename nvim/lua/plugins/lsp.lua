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
    {
      "ivanjermakov/troublesum.nvim", -- Diagnostic signs in the buffer
      event = "LspAttach",
      opts = {
        enabled = function()
          local ft = vim.bo.filetype
          return ft ~= "lazy" and ft ~= "mason" and ft ~= "codecompanion"
        end,
        severity_format = vim
          .iter(ipairs(icons))
          :map(function(sev, icon)
            return icon
          end)
          :totable(),
      },
    },
  },
  config = function()
    local nvim_lsp = require('lspconfig')
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer

    -- LspAttach is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("dotfiles.lsp-attach", { clear = false }),
      desc = "LSP actions",
      callback = function(event)
        -- print("LSP attached to buffer " .. event.buf)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(event.buf, ...) end
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
    end,
    })

    require("mason-lspconfig").setup({
      handlers = {
        -- this first function is the "default handler"
        -- it applies to every language server without a "custom handler"
        function(ls)
          require("lspconfig")[ls].setup({
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            },
          })
        end,
      },
    })

    vim.diagnostic.config({
      severity_sort = true,
      signs = {
        text = icons,
      },
      underline = false,
      update_in_insert = true,
      virtual_text = false,
      -- virtual_text = {
      --   prefix = "",
      --   spacing = 0,
      -- },
    })
  end,
}
