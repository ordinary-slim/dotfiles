return {
  'christoomey/vim-tmux-navigator',
  config = function()
    -- Use ctrl-[hjkl] to select the active split!
    vim.keymap.set('n', '<silent>', '<c-k> :wincmd k<CR>')
    vim.keymap.set('n', '<silent>', '<c-j> :wincmd j<CR>')
    vim.keymap.set('n', '<silent>', '<c-h> :wincmd h<CR>')
    vim.keymap.set('n', '<silent>', '<c-l> :wincmd l<CR>')
  end,
}

