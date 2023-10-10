local keymap = vim.keymap

keymap.set('n', '<Leader>w', ':wa<cr>')
keymap.set('n', '<Leader>q', ':qa<cr>')
keymap.set('n', '<Leader>c', ':close<cr>')
keymap.set('n', '<Leader>d', ':bp|bd #<cr>')
keymap.set('n', '<Leader>r', ':e<cr>zz')
keymap.set('n', '<Leader>w', ':lua ToggleQuickFixWindow()<cr>')
keymap.set('n', '<Leader>tc', ':tabclose<cr>')

-- Telescope
local tlsc_builtin = require("telescope.builtin")
keymap.set('n', '<leader>ff', tlsc_builtin.find_files, {})
keymap.set('n', '<leader>fg', tlsc_builtin.live_grep, {})
keymap.set('n', '<leader>fb', tlsc_builtin.buffers, {})
keymap.set('n', '<leader>fh', tlsc_builtin.help_tags, {})
keymap.set('n', '<leader>fr', tlsc_builtin.oldfiles, {})

-- Use ctrl-[hjkl] to select the active split!
keymap.set('n', '<silent>', '<c-k> :wincmd k<CR>')
keymap.set('n', '<silent>', '<c-j> :wincmd j<CR>')
keymap.set('n', '<silent>', '<c-h> :wincmd h<CR>')
keymap.set('n', '<silent>', '<c-l> :wincmd l<CR>')

-- navigate buffer list
keymap.set('n', '<c-n>', ':bn<cr>')
keymap.set('n', '<c-p>', ':bp<cr>')
keymap.set('n', '<BS>', '<c-^>')

-- navigate quickfix list
keymap.set('n', ']q', ':cnext<cr>')
keymap.set('n', '[q', ':cprev<cr>')

-- TO CHANGE: not overwriting content of register p
-- insert new line and come back at exact position
keymap.set('n', '<cr>', ':normal mpo<Esc>`p')

