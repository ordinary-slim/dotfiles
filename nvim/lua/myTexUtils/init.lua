-- local loop = vim.loop

local myTexUtils = {}

myTexUtils.texC    = "pdflatex" --tex compiler
myTexUtils.texF    = "-shell-escape" --tex compilation flags
myTexUtils.bibtex  = "bibtex"

-- Functions
function myTexUtils:getTexDriver()
  -- Get path of driver tex file which will be compiled
  -- TO-DO: fully move GetTexBuffer from commit e6ae46f
  return "main.tex"
end
function myTexUtils:compileTex()
  -- LaTeX compile in background
  handle = vim.loop.spawn(self.texC, {
  args = {self.getTexDriver()},
  },
  function (code, signal) -- on exit callback
    if (code~=0) then
      print(code .. " prev comm failed")
    end
  end
  )
end

-- Mappings
vim.keymap.set('n', '<F8>', '<cmd>lua require"myTexUtils":compileTex()<cr>')

return myTexUtils
