return
  {'olimorris/codecompanion.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    {
      "<LocalLeader>x",
      "<cmd>CodeCompanionActions<CR>",
      desc = "Open the action palette",
      mode = { "n", "v" },
    },
    {
      "<LocalLeader>a",
      "<cmd>CodeCompanionChat Toggle<CR>",
      desc = "Toggle a chat buffer",
      mode = { "n" },
    },
    {
      "<localleader>a",
      "<cmd>CodeCompanionChat Add<cr>",
      desc = "add code to a chat buffer",
      mode = { "v" },
    },
  },
    config = function()
      require("codecompanion").setup({
        adapters = {
          acp = {
            codex = function()
              return require("codecompanion.adapters").extend("codex", {
                defaults = {
                  auth_method = "chat-gpt", -- "api-key"|"chat-gpt"
                },
                -- env = {
                --   OPENAI_API_KEY = "my-api-key",
                -- },
              })
            end,
          },
        },
      })
    end,
  }
