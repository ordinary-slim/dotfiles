local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local ri = require('luasnip_utils').ri

ls.add_snippets("tex", {
	s(
		"benv",
		fmt([[
        \begin{{{}}}
          {}
        \end{{{}}}
        ]], {
		i(1, "environment"),
		i(2, "/* LaTeX code */"),
		ri(1),
		})
	),
	s(
		"int",
		fmt([[
        \int_{{{}}}^{{{}}} {}
        ]], {
		i(1, ""),
		i(2, ""),
		i(3, ""),
		})
	),
  s(
  "up",
  fmt([[
      \usepackage{{{}}}
      {}
      ]], {
	i(1, "package"),
	i(2),
  })
  ),
})
