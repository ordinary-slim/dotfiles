return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    keys = {
      {
        "<M-s>",
        ':lua require("copilot.suggestion").toggle_auto_trigger()<cr>',
        mode = {"n"},
      },
    },
    config = function()
      require('copilot').setup({})
    end
  },
}
