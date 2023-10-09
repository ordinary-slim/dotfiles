local keymap = vim.keymap
vim.g.mapleader = ' '

keymap.set('n', '<Leader>w', ':wa<cr>')
keymap.set('n', '<Leader>q', ':qa<cr>')
keymap.set('n', '<Leader>c', ':close<cr>')
keymap.set('n', '<Leader>d', ':bp|bd #<cr>')
keymap.set('n', '<Leader>r', ':e<cr>zz')
keymap.set('n', '<Leader>w', ':call ToggleQuickFixWindow()<cr>')
keymap.set('n', '<Leader>tc', ':tabclose<cr>')

-- Telescope
keymap.set('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
keymap.set('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
keymap.set('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>")
keymap.set('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>")

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

