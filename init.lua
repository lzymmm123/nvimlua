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


opt.termguicolors = true
opt.expandtab = true
opt.hidden = true
opt.list = true
opt.number = true
opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.listchars = {eol = '↲', tab = '▸ ', trail = '·'}

vim.o.completeopt = "menu,noselect"

api.nvim_set_keymap('','<Space>','<Nop>',{noremap = true, silent = true})

g.mapleader = ","
g.maplocalleader = " "

map('n','H','0')
map('n','L','$')
map('o','H','0')
map('o','L','$')
map('n','Q','<esc>:wq<cr>')
map('n','S','<esc>:w<cr>')
map('n','y0','0p')

map('n','<c-j>','<c-w>j')
map('n','<c-k>','<c-w>k')
map('n','<c-h>','<c-w>h')
map('n','<c-l>','<c-w>l')
map('n','<c-p>','<c-w>p')

map('n','s','<nop>')
map('n','sk',':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>')
map('n','sj',':set splitbelow<CR>:split<CR>')
map('n','sh',':set nosplitright<CR>:vsplit<CR>:set splitright<CR>')
map('n','sl',':set splitright<CR>:vsplit<CR>')



-- require("plugins")

cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

vim.cmd[[colorscheme nord]]


map('n','<localleader>e',':NvimTreeToggle<cr>')
map('n','j','<Plug>(accelerated_jk_gj_position)',{noremap = false})
map('n','k','<Plug>(accelerated_jk_gk_position)',{noremap = false})

