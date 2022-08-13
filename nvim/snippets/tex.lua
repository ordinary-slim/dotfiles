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
  s("ternary", {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
  }),
  s("hallo", {
    t("Baaaaaaaaby!"),
  }),
  s("test", {
    i(1, 'insert node'),
    t({'', 'some other text on a new line', ''}),
    ri(1),
  }),
})
