local ls = require("luasnip")

-- lazy load by filename / path
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})

-- Virtual Text{{{
local types = require("luasnip.util.types")
ls.config.set_config({
	history = true, --keep around last snippet local to jump back
	updateevents = "TextChanged,TextChangedI", --update changes as you type
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } },
			},
		},
		-- [types.insertNode] = {
		-- 	active = {
		-- 		virt_text = { { "●", "GruvboxBlue" } },
		-- 	},
		-- },
	},
}) --}}}

-- Util functions for snippets
-- Repeat Insertnode text
-- @param insert_node_id The id of the insert node to repeat (the first line from)
local ri = function (insert_node_id)
    return f(function (args) return args[1][1] end, insert_node_id)
end
