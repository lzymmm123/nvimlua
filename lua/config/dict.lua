local dict = require 'cmp_dictionary'
dict.setup({
    dic = {
      ["tex,md,txt"] = { "/usr/share/dict/words" },
    },
    -- The following are default values.
    exact = 2,
    first_case_insensitive = false,
    ----document = false,
    ----document_command = "wn %s -over",
    --async = false, 
    capacity = 5,
    --debug = true,
  })
