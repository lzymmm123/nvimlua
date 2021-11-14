local Popup = require("nui.popup")
local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local M = {}
M.replace = function ()
  local w = vim.fn.expand("<cword>")
  local popup_options = { --local
    relative = "cursor",
    position = {
      row = 1,
      col = 0,
    },
    size = {
      width = 20,
      height = 1,
    },
    enter = true,
    border = {
      style = 'single',
      highlight = "FloatBorder",
    },
  }

  local input = Input(popup_options, {
    prompt = "> ",
    default_value = w,
    on_submit = function(value)
      local e = "s/"..w.."/"..value.."/g"
      vim.api.nvim_command(e)
    end,
  })
  input:mount()
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

M.get_region = function (vmode)
  local m = vim.api.nvim_buf_get_mark
  local buf = 0
  local sln, eln
  if vmode:match('[vV]') then
    sln = m(buf, '<')
    eln = m(buf, '>')
  else
    sln = m(buf, '[')
    eln = m(buf, ']')
  end
  return sln[1], eln[1], sln[2], eln[2]
end

M.get_lines = function(vmode)
  local srow, erow, scol, ecol = M.get_region(vmode)

  local lines
  if srow == erow then
    lines = { vim.api.nvim_get_current_line() }
  else
    lines = vim.api.nvim_buf_get_lines(0,srow-1,erow, false)
  end
  print(vim.inspect(lines))
end

return M
