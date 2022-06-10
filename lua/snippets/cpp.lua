--local ls = require("luasnip")
--local s = ls.snippet
--local sn = ls.snippet_node
--local t = ls.text_node
--local i = ls.insert_node
--local f = ls.function_node
--local c = ls.choice_node
--local d = ls.dynamic_node

return {
  s("incc",{
    t({"#include<"}),
    i(1,'iostream'),
    t({">"}),
  }),
  s("leet", {
    t({"#include<iostream>","#include<algorithm>","#include<vector>","#include<numeric>","#include<map>","#include<set>","#include<unordered_map>","#include<unordered_set>","#include<functional>","#include<string>", "using namespace std;" })
  }),
  s("main", {
    t({"int main(int argv, char* argc[]){","}"}),
  }),
}
