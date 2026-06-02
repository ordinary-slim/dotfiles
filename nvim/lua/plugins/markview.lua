return {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- Completion for `blink.cmp`
    -- dependencies = { "saghen/blink.cmp" },
    --
    keys = {
      vim.api.nvim_set_keymap("n", "<leader>m", "<CMD>Markview<CR>", { desc = "Toggle `markview` globally" });
      {
        "<Leader>m",
        function()
          require("markview").toggle()
          print("Markview " .. (vim.b.markview and "enabled" or "disabled"))
        end,
        mode = {"n", "i"},
      },
    },
}
