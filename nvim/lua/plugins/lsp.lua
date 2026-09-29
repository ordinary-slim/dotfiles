return {
  "mason-org/mason-lspconfig.nvim",
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim",
      opts = {
        ui = {
          border = "single",
        },
      },
    },
    { "neovim/nvim-lspconfig",
      config = function()
      end
    },
  },
}
