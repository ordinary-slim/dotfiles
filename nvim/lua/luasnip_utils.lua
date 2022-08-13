local utils = {}

local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node

-- Repeat Insertnode text
-- @param insert_node_id The id of the insert node to repeat (the first line from)
utils.ri = function (insert_node_id)
    return f(function (args) return args[1][1] end, insert_node_id)
end

return utils
