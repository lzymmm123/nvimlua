local map = require('config.utils').map

local silent = { silent = true }
-- Navigate buffers and repos
map('n', '<c-p>', [[<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>]], silent)
map('n', '<c-e>', [[<cmd>Telescope frecency theme=get_dropdown<cr>]], silent)
map('n', '<c-s>', [[<cmd>Telescope git_files theme=get_dropdown<cr>]], silent)
map('n', '<c-f>', [[<cmd>Telescope find_files theme=get_dropdown<cr>]], silent)
map('n', 'sm', [[<cmd>Telescope grep_string theme=get_dropdown<cr>]], silent)
map('n', '<leader><leader>', [[<cmd>Telescope<cr>]], silent)
map('n', '<leader>f', [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], silent)
