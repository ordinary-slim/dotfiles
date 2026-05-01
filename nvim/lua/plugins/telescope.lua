return {
  {'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- Telescope
      local tlsc_builtin = require("telescope.builtin")
      local keymap = vim.keymap
      keymap.set('n', '<leader>ff', function() tlsc_builtin.find_files({cwd=(vim.fn.expand "%:p:h")}) end, {})
      keymap.set('n', '<leader>fg', tlsc_builtin.live_grep, {})
      keymap.set('n', '<leader>fb', tlsc_builtin.buffers, {})
      keymap.set('n', '<leader>fh', tlsc_builtin.help_tags, {})
      keymap.set('n', '<leader>fr', tlsc_builtin.oldfiles, {})
    end
  },
}
