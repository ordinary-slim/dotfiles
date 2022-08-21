-- local loop = vim.loop

local myTexUtils = {}

myTexUtils.texC    = "pdflatex" --tex compiler
myTexUtils.texF    = "-shell-escape" --tex compilation flags
myTexUtils.bibtex  = "bibtex"

-- Functions
function myTexUtils:getTexDriver()
  --[[
  Get path of driver tex file which will be compiled from buffer list
  TO-DO: fully move GetTexBuffer from commit e6ae46f
  --]]
  return "main.tex"
end
function myTexUtils:compileTex()
  -- LaTeX compile in background
  vim.cmd("wall") -- write all changed buffers
  print("Compiling ...")
  handle = vim.loop.spawn(self.texC, {
  args = {self:getTexDriver()},
  },
  function (code, signal) -- on exit callback
    if (code==0) then
      print("Last compile succeeded")
    else
      print("Last compile FAILED, check logfile")
    end
  end
  )
end
function myTexUtils:callBibTex()
  -- bibtex call in background
  vim.cmd("wall") -- write all changed buffers
  print("Calling BibTex ...")
  target = self:getTexDriver()
  target = target:match("(%w+)%..+$")--keep only filename
  handle = vim.loop.spawn(self.bibtex, {
  args = {target},
  },
  function (code, signal) -- on exit callback
    if (code==0) then
      print("Last bibtex succeeded")
    else
      print("Last bibtex FAILED, check logfile")
    end
  end
  )
end

return myTexUtils
