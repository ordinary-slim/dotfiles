return {
  {'sakhnik/nvim-gdb', config = function()
    vim.g.nvimgdb_config_override = {
      key_step = "ctrl-s",
    }
  end},
}
-- { 'do': ':!./install.sh' }
-- let w:nvimgdb_termwin_command = "belowright new"
