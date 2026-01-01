-- NOTE: Most keybind related plugins are in their respective plugin files
local keymap = vim.keymap

keymap.set('n', '<Leader>w', ':wa<cr>')
keymap.set('n', '<Leader>q', ':qa<cr>')
keymap.set('n', '<Leader>c', ':close<cr>')
keymap.set('n', '<Leader>d', ':bp|bd #<cr>')
keymap.set('n', '<Leader>r', ':e<cr>zz')
keymap.set('n', '<Leader>w', ':lua common.ToggleQuickFixWindow()<cr>')
keymap.set('n', '<Leader>tc', ':tabclose<cr>')
-- <CTRL-]> (go to tag) is buggy in QWERTY keyboard. Spanish keyboard equivalent is <CTRL-5>
-- See https://stackoverflow.com/questions/6932702/how-do-i-type-ctrl-on-a-qwertz-keyboard-in-order-to-jump-to-a-tag-with-vim
-- keymap.set('n', '<Leader>]', '<c-]>')

-- Telescope
-- TODO: Move to plugin config file
local tlsc_builtin = require("telescope.builtin")
keymap.set('n', '<leader>ff', function() tlsc_builtin.find_files({cwd=(vim.fn.expand "%:p:h")}) end, {})
keymap.set('n', '<leader>fg', tlsc_builtin.live_grep, {})
keymap.set('n', '<leader>fb', tlsc_builtin.buffers, {})
keymap.set('n', '<leader>fh', tlsc_builtin.help_tags, {})
keymap.set('n', '<leader>fr', tlsc_builtin.oldfiles, {})

-- navigate buffer list
keymap.set('n', '<c-n>', ':bn<cr>')
keymap.set('n', '<c-p>', ':bp<cr>')
keymap.set('n', '<BS>', '<c-^>')

-- navigate quickfix list
keymap.set('n', ']q', ':cnext<cr>')
keymap.set('n', '[q', ':cprev<cr>')
