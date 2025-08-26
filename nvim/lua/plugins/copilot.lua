return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    keys = {
      {
        "<M-s>",
        function()
          require("copilot.suggestion").toggle_auto_trigger()
          print("Copilot suggestions " .. (vim.b.copilot_suggestion_auto_trigger and "enabled" or "disabled"))
        end,
        mode = {"n", "i"},
      },
    },
    config = function()
      require('copilot').setup({})
    end
  },
}
