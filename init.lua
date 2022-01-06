local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt
local api = vim.api

local function map(mode,lhs,rhs,opts)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend('force',options,opts) end
    vim.api.nvim_set_keymap(mode,lhs,rhs,options)
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmd [[au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape']]

opt.expandtab = true
opt.termguicolors = true
opt.hidden = true
opt.list = true
opt.number = true
--opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.listchars = {eol = '↲', tab = '▸ ', trail = ' ',space = ' '}

vim.o.completeopt = "menu,noselect"
opt.timeoutlen=1000
opt.ttimeoutlen=0

api.nvim_set_keymap('','<Space>','<Nop>',{noremap = true, silent = true})

g.mapleader = ","
g.maplocalleader = " "
map('n','H','0')
map('n','L','$')
map('o','H','0')
map('o','L','$')
map('x','H','0')
map('x','L','$')
map('n','m','g*')
map('n','Q','<esc>:q<cr>')
map('n','S','<esc>:w<cr>')
map('n','y0','0p')
map('v','Y','"+y')

map('n','<localleader><cr>',':nohl<cr>')

map('n','<c-j>','<c-w>j')
map('n','<c-k>','<c-w>k')
map('n','<c-h>','<c-w>h')
map('n','<c-l>','<c-w>l')
map('n','<c-p>','<c-w>p')

map('n','s','<nop>')
map('n','sk',':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>')
map('n','sj',':set splitbelow<CR>:split<CR>')
map('n','sh',':set nosplitright<CR>:vsplit<CR>:set splitright<CR>')
map('n', 'sl',':set splitright<CR>:vsplit<CR>')
map('n', '<leader><up>', ':res +5<cr>')
map('n', '<leader><down>',  ':res -5<cr>')
map('n', '<leader><left>',  ':vertical resize-5<cr>')
map('n', '<leader><right>', ':vertical resize+5<cr>')



-- require("plugins")

cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

vim.cmd[[colorscheme nord]]


map('n','<localleader>e',':NvimTreeToggle<cr>')
map('n','j','<Plug>(accelerated_jk_gj)',{noremap = false})
map('n','k','<Plug>(accelerated_jk_gk)',{noremap = false})
map('n','<localleader>m','<Plug>NERDCommenterToggle',{noremap = false})
map('v','<localleader>m','<Plug>NERDCommenterToggle',{noremap = false})
map('n','<localleader>b',[[:lua require('telescope').extensions.asynctasks.all()<cr>]],{noremap = false})
map('n', '<localleader><localleader>', [[<cmd>Telescope<cr>]])
map('n', '<localleader>d', [[<cmd>Telescope lsp_workspace_diagnostics<cr>]])

map('x','ga','<Plug>(EasyAlign)',{noremap = false})
map('n','ga','<Plug>(EasyAlign)',{noremap = false})


map('n', ';c',':HopChar1<cr>')
map('n', ';w',':HopChar2<cr>')
map('n', ';p',':HopPattern<cr>')
map('n', ';l',':HopLine<cr>')
map('o', ';c',':HopChar1<cr>')
map('o', ';w',':HopChar2<cr>')
map('o', ';p',':HopPattern<cr>')
map('o', ';l',':HopLine<cr>')
map('o', 'f', ':HopChar1Line<cr>')
map('v', 'f',[[<cmd>lua require('hop').hint_words()<CR>]])


g.wildfire_objects      = {"i'", 'i"', "i)", "i]", "i>","i}","ip","it"}

g.asyncrun_open         = 6
g.asyncrun_rootmarks    = {'.git','.svn','.root','.project','.hg','.projectile'}
g.asynctasks_term_pos   = 'right'
g.asynctasks_term_rows  = 10    -- 设置纵向切割时，高度为 10
g.asynctasks_term_cols  = 80    -- 设置横向切割时，宽度为 80
g.asynctasks_term_reuse = 1


local function luasnip_choice()
    local snip = require('luasnip')
    if snip.choice_active() then
        print("yes")
        return t '<Plug>luasnip-next-choice'
    end
    return t "<C-E>"
end

vim.cmd[[imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']]
vim.cmd[[vmap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']]
vim.cmd[[smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']]


vim.cmd[[nmap <silent> <localleader>t <Plug>TranslateW]]
vim.cmd[[vmap <silent> <localleader>t <Plug>TranslateWV]]

vim.cmd[[nmap <silent> <localleader>y :Telescope neoclip<cr>]]



local function matchstr(...)
  local ok, ret = pcall(fn.matchstr, ...)
  if ok then
    return ret
  end
  return ""
end

vim.cmd[[nmap <silent> cp <cmd>lua require("tools").replace()<cr>]]
vim.cmd[[vmap <silent> cp <cmd>lua require("tools").replace()<cr>]]


--vim.cmd[[nmap <silent> <localleader>e :NvimTreeToggle<cr>]]
