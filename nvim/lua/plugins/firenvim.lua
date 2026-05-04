return {
  'glacambre/firenvim',
  build = ":call firenvim#install(0)",
  -- https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  lazy = not vim.g.started_by_firenvim,
  enabled = vim.g.started_by_firenvim,
  module = false,
  config = function()
    if vim.g.started_by_firenvim then
      -- Firenvim specific settings
      vim.o.guifont = "Fira Mono Retina:h12"
      vim.o.linespace = 0
      vim.o.laststatus = 0
      vim.o.number = false
      vim.o.relativenumber = false
      vim.o.background = 'light'

      vim.g.firenvim_config = {
          globalSettings = {
              ignoreKeys = {
                  all = { '<C-->', '<C-+>' },
              }
          },
          localSettings = {
              [".*"] = {
                  priority = 0,
                  takeover = "never"
              },
              [".*localhost.*"] = { -- jupyter notebook
                  priority = 1,
                  cmdline = 'firenvim',
                  takeover = "always",
                  filename = '/tmp/{hostname}_{pathname%10}.py'
              },
          }
      }
      -- vim.api.nvim_set_keymap("n", '<Leader>q', 'silent write<cr>vim.cmd("call firenvim#hide_frame()<cr>")', { noremap = true, silent = true })
      -- vim.api.nvim_create_autocmd({'TextChanged', 'TextChangedI'}, {
      --     callback = function(e)
      --         if vim.g.timer_started == true then
      --             return
      --         end
      --         vim.g.timer_started = true
      --         vim.fn.timer_start(500, function()
      --             vim.g.timer_started = false
      --             vim.cmd('silent write')
      --         end)
      --     end
      -- })
      vim.api.nvim_create_autocmd("InsertLeave", {
        nested = true, -- https://github.com/glacambre/firenvim/issues/1673
        callback = function()
          vim.cmd('silent write')
        end,
      })
    end
  end,
  keys = vim.g.started_by_firenvim and {
    {'<Leader>q', function()
      vim.cmd.write()
      vim.cmd.quit()
    end, desc = "Close Firenvim frame", mode = "n"},
  }
}
