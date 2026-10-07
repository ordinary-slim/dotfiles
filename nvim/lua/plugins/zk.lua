return {
  "zk-org/zk-nvim",
  name = "zk",
  opts = {
    -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
    -- or select" (`vim.ui.select`).
    picker = "telescope",

    lsp = {
      -- `config` is passed to `vim.lsp.start(config)`
      config = {
        name = "zk",
        cmd = { "zk", "lsp" },
        filetypes = { "markdown" },
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start()`
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
      },
    },

    tags = {
      -- Configure how multiple tags should be combined in a ZkTags search
      -- Can be "AND" or "OR"
      multi_select_strategy = "AND",
    }
  },
  config = function(_, opts)
    local zk = require("zk")
    zk.setup(opts)

    local function journal_entry()
      zk.new({ dir = "journal/daily" })
    end

    for _, cname in ipairs({"ZkDaily", "ZkToday"}) do
      vim.api.nvim_create_user_command(cname, journal_entry, {
        desc = "Create or open today's journal note",
      })
    end
  end,
}
