local function bash(_, _, command)
  local file = io.popen(command,"r")
  local res = {}
  for line in file:lines() do
    table.insert(res,line)
  end
  return res
end

return {
  s("time", p(os.date, "%Y-%m-%d")),

  s({
    trig = "pwd",
    name = "PWD",
    dscr = "Path of current working directory",
  },{
    f(bash,{}, { user_args = {"pwd"} })
  }),
}
