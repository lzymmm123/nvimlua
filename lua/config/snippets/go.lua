local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node


local snips = {
    s("fn",{
      t({"func"}),
      t({"("}),
      i(1,'val type'),
      t({") "}),
      i(2,"funcname"),
      t({"("}),
      i(3,"arguments"),
      t({") "}),
      i(4,"return_type "),
      t({"{", "\t"}),
      i(0),
      t({"","}"}),
    }),

    s("ifnil",{
      t("if "),
      i(1,"err"),
      t({" != nil {","\t"}),
      i(0,"return"),
      t({"","}"}),
    })
}

return snips

