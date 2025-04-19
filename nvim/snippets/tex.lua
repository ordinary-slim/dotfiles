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
  s(
  "itemize",
  fmt([[
      \begin{{itemize}}
        \item {}
      \end{{itemize}}
      ]], {
      i(1, "/** Item **/"),
  })
  ),
  s(
  "itm",
  fmt([[
      \item {}
      ]], {
      i(1, "/** Item **/"),
    })
  ),
  s(
  "figure",
  fmt([[
      \begin{{figure}}[ht]
        \centering
        {}
        \caption{{{}}}
        \label{{fig:{}}}
      \end{{figure}}
      ]], {
        i(1, "/*Figure command*/"),
        i(2, "/*Figure caption*/"),
        i(3, "/*Figure label*/"),
      })
  ),
  s(
  "ig",
  fmt([[
      \includegraphics[width={}\textwidth]{{{}}}
      ]], {
        i(1, "0.5"),
        i(2, "/*Graphics path*/"),
      })
  ),
  s(
  "cig",
  fmt([[
      \castelincfig[{}]{{{}}}
      ]], {
        i(1, "0.5"),
        i(2, "/*Graphics path*/"),
      })
  ),
  s(
  "bf",
  fmt([[
      \textbf{{{}}}
      ]], {
        i(1, "/*bold text*/"),
      })
  ),
  s(
  "mbf",
  fmt([[
      \mathbf{{{}}}
      ]], {
        i(1, "/*bold math*/"),
      })
  ),
  s(
  "ttt",
  fmt([[
      \texttt{{{}}}
      ]], {
        i(1, "/*fixed space text*/"),
      })
  ),
  s(
  "it",
  fmt([[
      \textit{{{}}}
      ]], {
        i(1, "/*itallic text*/"),
      })
  ),
  s(
  "eqt",
  fmt([[
      \begin{{{}}}
        {}
      \end{{{}}}
      ]], {
        i(1, "equation*"),
        i(2, ""),
        ri(1),
      })
  ),
})
