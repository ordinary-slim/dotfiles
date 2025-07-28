local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node

ls.add_snippets("all", {
	s(
		"mysnip",
		fmt([[
        s(
        "{}",
        {}
        ),
        ]], {
		i(1, "Snippet name"),
    i(2, 't("Basic snippet")'),
		})
	),
})
