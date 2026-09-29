-- NOTE: Most keybind related plugins are in their respective plugin files
local keymap = vim.keymap

keymap.set('n', '<Leader>w', ':wa<cr>')
keymap.set('n', '<Leader>q', ':qa<cr>')
keymap.set('n', '<Leader>c', ':close<cr>')
keymap.set('n', '<Leader>d', ':bp|bd #<cr>')
keymap.set('n', '<Leader>r', ':e<cr>zz')
keymap.set('n', '<Leader>W', ':lua common.ToggleQuickFixWindow()<cr>')
keymap.set('n', '<Leader>tc', ':tabclose<cr>')
-- copy filepath into clipboard
keymap.set('n', '<Leader>y', ':let @+=expand("%:p")<cr>')
-- <CTRL-]> (go to tag) is buggy in QWERTY keyboard. Spanish keyboard equivalent is <CTRL-5>
-- See https://stackoverflow.com/questions/6932702/how-do-i-type-ctrl-on-a-qwertz-keyboard-in-order-to-jump-to-a-tag-with-vim
-- keymap.set('n', '<Leader>]', '<c-]>')

-- navigate buffer list
keymap.set('n', '<c-n>', ':bn<cr>')
keymap.set('n', '<c-p>', ':bp<cr>')
keymap.set('n', '<BS>', '<c-^>')

-- navigate quickfix list
keymap.set('n', ']q', ':cnext<cr>')
keymap.set('n', '[q', ':cprev<cr>')

-- lsp

keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end)
keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
keymap.set('n', 'K', function() vim.lsp.buf.hover() end)
keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end)
keymap.set('n', '<C-,>', function() vim.lsp.buf.signature_help() end)
keymap.set('n', 'gr', function() vim.lsp.buf.references() end)
keymap.set('n', '<space>wd', function() vim.lsp.buf.add_workspace_folder() end)
keymap.set('n', '<space>wr', function() vim.lsp.buf.remove_workspace_folder() end)
keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
keymap.set('n', '<space>D', function() vim.lsp.buf.type_definition() end)
keymap.set('n', '<space>rn', function() vim.lsp.buf.rename() end)
keymap.set('n', '<space>ca', function() vim.lsp.buf.code_action() end)
keymap.set('n', '<space>e', function() vim.diagnostic.open_float() end)
keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end)
keymap.set('n', ']d', function() vim.diagnostic.goto_next() end)
