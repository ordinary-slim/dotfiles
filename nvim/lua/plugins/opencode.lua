return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = "tmux",
        tmux = {
          -- ...
        },
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true
  end,

    -- Recommended/example keymaps.
    keys = {
      {"<Leader>a", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "Ask opencode" , mode = { "n", "x" },},
      {"<Leader>x", function() require("opencode").select() end, desc = "Execute opencode action…", mode = { "n", "x" },},
      {"<Leader>o", function() require("opencode").toggle() end, desc = "Toggle opencode", mode = { "n", "t" },},

      {"go", function() return require("opencode").operator("@this ") end, expr = true, desc = "Add range to opencode", mode = { "n", "x" },},
      {"goo", function() return require("opencode").operator("@this ") .. "_" end, expr = true, desc = "Add line to opencode", mode = "n",},

      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      -- NOTE: not sure what do these do
      -- vim.keymap.set("n", "+", "<Leader>a", { desc = "Increment", noremap = true })
      -- vim.keymap.set("n", "-", "<Leader>x", { desc = "Decrement", noremap = true })
    },
}
