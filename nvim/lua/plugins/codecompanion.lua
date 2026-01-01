return
  {'olimorris/codecompanion.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  -- keys = {
  --   {
  --     "<C-space>",
  --     "<cmd>CodeCompanionActions<CR>",
  --     desc = "Open the action palette",
  --     mode = { "n", "v" },
  --   },
  --   {
  --     "<Leader>a",
  --     "<cmd>CodeCompanionChat Toggle<CR>",
  --     desc = "Toggle a chat buffer",
  --     mode = { "n", "v" },
  --   },
  --   {
  --     "<LocalLeader>a",
  --     "<cmd>CodeCompanionChat Add<CR>",
  --     desc = "Add code to a chat buffer",
  --     mode = { "v" },
  --   },
  -- },
  config = function()
    require('codecompanion').setup({
    })
  end,
  }
