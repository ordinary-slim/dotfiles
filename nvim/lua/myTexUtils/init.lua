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
function myTexUtils:compileTex(optionalFlag)
  -- LaTeX compile in background
  vim.cmd("wall") -- write all changed buffers
  args = {self.texF, self:getTexDriver()}
  if optionalFlag then
    table.insert( args, 2, optionalFlag )
  end
  print("Compiling ...")
  handle = vim.loop.spawn(self.texC, {
    args = args,
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
  myTexUtils:callBibTexSub()
end
function myTexUtils:callBibTexSub()
  -- bibtex call in background on blx files
  vim.cmd("wall") -- write all changed buffers
  local cwdContents = vim.split(vim.fn.glob(vim.fn.getcwd() .. "/*"), '\n', {trimempty=true})
  local blxFiles = {}
  for _, cwdItem in pairs(cwdContents) do
    if (string.find(cwdItem,"blx.aux") ~= nil) then
      blxFile = vim.fn.fnamemodify(cwdItem,":t")
      table.insert(blxFiles,blxFile)
    end
  end
  if (next(blxFiles)==nil) then
    return
  else
    print("Calling BibTex on blx files...")
  end

  for _, blxFile in pairs(blxFiles) do
    handle = vim.loop.spawn(self.bibtex, {
    args = {blxFile},
    },
    function (code, signal) -- on exit callback
      if (code==0) then
        print("Last bibtex blx succeeded")
      else
        print("Last bibtex blx FAILED, check logfile")
      end
    end
    )
  end
end
function myTexUtils:longCompileTex()
  -- Calls tex once, bibtex once, tex twice
  -- TODO: Debug this
  compileTex()
  callBibTex()
  compileTex()
  compileTex()
end

return myTexUtils
