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

return M
