-- utility function
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saghen/blink.lib',
    },
    build = function()
      -- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
      -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
      require('blink.cmp').build():pwait()
    end,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'super-tab',
        -- ['<Tab>'] = {
        --   function(cmp)
        --     if cmp.snippet_active() then return cmp.accept()
        --     else return cmp.select_and_accept() end
        --   end,
        --   'snippet_forward',
        --   'fallback'
        -- },
        -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      },

      snippets = { preset = 'luasnip' },
      -- ensure you have the `snippets` source (enabled by default)
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"`
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "rust" }
    },
  }
}
