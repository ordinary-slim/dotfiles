return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require("telescope").load_extension("fzf")
      -- Telescope
      local tlsc_builtin = require("telescope.builtin")
      local keymap = vim.keymap
      keymap.set('n', '<leader>ff', function() tlsc_builtin.find_files({cwd=(vim.fn.expand "%:p:h")}) end, {})
      keymap.set('n', '<leader>fg', tlsc_builtin.live_grep, {})
      keymap.set('n', '<leader>fb', tlsc_builtin.buffers, {})
      keymap.set('n', '<leader>fh', tlsc_builtin.help_tags, {})
      keymap.set('n', '<leader>fr', tlsc_builtin.oldfiles, {})
    end
}
